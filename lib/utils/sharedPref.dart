

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  /// get exercise version from shared prefs
  readSharedVersionExercise(int exShared, trainingPlanShared) async {
    final prefs = await SharedPreferences.getInstance();
    exShared = prefs.getInt('exerciseVersion') ?? 0;
    return exShared;
  }
  /// get workout version from shared prefs
  readSharedVersionWorkout(int workoutShared) async {
    final prefs = await SharedPreferences.getInstance();
    workoutShared = prefs.getInt('workoutVersion') ?? 0;
    return workoutShared;
  }
  /// get trainingPlan version from shared prefs
  readSharedVersionTrainingplan(int trainingPlanShared) async {
    final prefs = await SharedPreferences.getInstance();
    trainingPlanShared = prefs.getInt('trainingPlanVersion') ?? 0;
    return trainingPlanShared;
  }

  writeSharedVersion(int exVersion, workoutVersion, trainingPlanVersion) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('exerciseVersion', exVersion);
    prefs.setInt('workoutVersion', workoutVersion);
    prefs.setInt('trainingPlanVersion', trainingPlanVersion);
  }

}