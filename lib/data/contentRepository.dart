import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/utils/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentRepository {
  static final ContentRepository _dbHelper = ContentRepository._internal();

  ContentRepository._internal();

  factory ContentRepository() {
    return _dbHelper;
  }

  static Firestore _db;

  Future<Firestore> get db async {
    if (_db == null) {
      _db = await Firestore.instance;
    }
    return _db;
  }

  checkVersion() async {
    Firestore db = await this.db;
    var sharedPref = SharedPref();
    int versionFromSharedExercise,
        versionFromSharedWorkout,
        versionFromSharedTrainingPlan,
        versionFromServerExercise,
        versionFromServerWorkout,
        versionFromServerTrainingPlan;

    final prefs = await SharedPreferences.getInstance();

    /// local version exercise
    versionFromSharedExercise = prefs.getInt('exerciseVersion') ?? 0;

    /// local version workout
    versionFromSharedWorkout = prefs.getInt('workoutVersion') ?? 0;

    /// lokalna verzija training
    versionFromSharedTrainingPlan = prefs.getInt('trainingPlanVersion') ?? 0;

    /// server verzija
    DocumentSnapshot qn = await db
        .collection('versions')
        .document('bsjRzcG4O8PEi3Dq0BbB')
        .get(source: Source.serverAndCache)
        .then((value) {
      value.data.forEach((key, value) {
        versionFromServerExercise = value[0]['version'];
        versionFromServerWorkout = value[1]['version'];
        versionFromServerTrainingPlan = value[2]['version'];
      });
      return;
    });
    print('VERSION FROM SHARED PREFS ex: $versionFromSharedExercise');
    print('VERSION FROM server ex : $versionFromServerExercise');
    print('VERSION FROM SHARED PREFS w: $versionFromSharedWorkout');
    print('VERSION FROM server w : $versionFromServerWorkout');
    print('VERSION FROM SHARED PREFS tp: $versionFromSharedTrainingPlan');
    print('VERSION FROM server tp : $versionFromServerTrainingPlan');

    /// check for version exercise
    if (versionFromServerExercise != versionFromSharedExercise) {
      await db.collection('exercises').getDocuments(source: Source.server);
      sharedPref.writeSharedVersion(versionFromServerExercise,
          versionFromServerWorkout, versionFromServerTrainingPlan);
      print('Razlicite su verzije i skidam novi kontent Exercise');
    }

    /// check for version workout
    if (versionFromServerWorkout != versionFromSharedWorkout) {
      await db.collection('workouts').getDocuments(source: Source.server);
      sharedPref.writeSharedVersion(versionFromServerExercise,
          versionFromServerWorkout, versionFromServerTrainingPlan);
      print('Razlicite su verzije i skidam novi kontent Workout');
    }

    /// check for version trainingPlan
    if (versionFromServerTrainingPlan != versionFromSharedTrainingPlan) {
      await db.collection('trainingPlan').getDocuments(source: Source.server);
      sharedPref.writeSharedVersion(versionFromServerExercise,
          versionFromServerWorkout, versionFromServerTrainingPlan);
      print('Razlicite su verzije i skidam novi kontent TrainingPlan');
    }
  }
}
