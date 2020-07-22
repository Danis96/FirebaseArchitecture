import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/data/exerciseModel.dart';
import 'package:firebasedrill/data/source/exerciseRepository.dart';
import 'package:firebasedrill/data/versionModel.dart';
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
    var exerciseRepo = ExerciseRepository();
    List<dynamic> versions = [];
    int versionFromSharedExercise,
        versionFromSharedWorkout,
        versionFromSharedTrainingPlan;

    final prefs = await SharedPreferences.getInstance();

    /// local version exercise
    versionFromSharedExercise = prefs.getInt('exerciseVersion') ?? 0;

    /// local version workout
    versionFromSharedWorkout = prefs.getInt('workoutVersion') ?? 0;

    /// lokalna verzija training
    versionFromSharedTrainingPlan = prefs.getInt('trainingPlanVersion') ?? 0;

    /// server verzija
    await db
        .collection('versions')
        .getDocuments(source: Source.server)
        .then((QuerySnapshot snapshot) {
      versions =
          snapshot.documents.map((e) => VersionModel.fromDocument(e)).toList();
      return;
    });
    print('VERSION FROM SHARED PREFS ex: $versionFromSharedExercise');
    print('VERSION FROM server ex : ' + versions[0].exerciseVersion.toString());
    print('VERSION FROM SHARED PREFS w: $versionFromSharedWorkout');
    print('VERSION FROM server w : ' + versions[0].workoutVersion.toString());
    print('VERSION FROM SHARED PREFS tp: $versionFromSharedTrainingPlan');
    print('VERSION FROM server tp : ' +
        versions[0].trainingPlanVersion.toString());

    /// check for version exercise
    if (versions[0].exerciseVersion != versionFromSharedExercise) {
      await db.collection('exercises').getDocuments(source: Source.server);
      sharedPref.writeSharedVersion(versions[0].exerciseVersion,
          versions[0].workoutVersion, versions[0].trainingPlanVersion);
      print('Razlicite su verzije i skidam novi kontent Exercise');
    } else {
       exerciseRepo.getExerciseCollection();
    }

    /// check for version workout
    if (versions[0].workoutVersion != versionFromSharedWorkout) {
      await db.collection('workouts').getDocuments(source: Source.server);
      sharedPref.writeSharedVersion(versions[0].exerciseVersion,
          versions[0].workoutVersion, versions[0].trainingPlanVersion);
      print('Razlicite su verzije i skidam novi kontent Workout');
    }

    /// check for version trainingPlan
    if (versions[0].trainingPlanVersion != versionFromSharedTrainingPlan) {
      await db.collection('trainingPlan').getDocuments(source: Source.server);
      sharedPref.writeSharedVersion(versions[0].exerciseVersion,
          versions[0].workoutVersion, versions[0].trainingPlanVersion);
      print('Razlicite su verzije i skidam novi kontent TrainingPlan');
    }
  }
}
