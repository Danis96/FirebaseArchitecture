import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/data/exerciseRepository.dart';
import 'package:firebasedrill/data/trainingPlanRepository.dart';
import 'package:firebasedrill/data/versionRepository.dart';
import 'package:firebasedrill/data/workoutRepository.dart';


/// exercise view model
class EViewModel {
  var exerciseRepository = ExerciseRepository();

  Future getAllExercises(int version) {
    return exerciseRepository.getExerciseCollection(version);
  }

  Future getSpecificExercise(String id, Source source) {
    return exerciseRepository.getExerciseDocument(id, source);
  }

  Future addExercise(String bodyTag, name) {
    return exerciseRepository.createExercise(bodyTag, name);
  }
}

/// workout view model
class WorkoutViewModel {
    var workoutRepository = WorkoutRepository();

    Future getAllWorkouts(int version) {
       return workoutRepository.getWorkoutCollection(version);
    }

    Future getSpecificWorkout(String id, int version) {
       return workoutRepository.getWorkoutDocument(id, version);
    }

    Future createWorkout(String day, name, exerciseID, time, int reps) {
      return workoutRepository.createWorkout(day, name, exerciseID, time, reps);
    }
}

/// training plan view model
class TrainingPlanViewModel {
    var trainingPlanRepository = TrainingPlanRepository();

    Future getAllTrainingPlans(int version) {
       return trainingPlanRepository.getTrainingPlanCollection(version);
    }

    Future getSpecificTrainingPlan(String id, int version) {
       return trainingPlanRepository.getTrainingPlanDocument(id, version);
    }

    Future createTrainingPlan(String time, name, workoutID) {
      return trainingPlanRepository.createTrainingPlan(time, name, workoutID);
    }
}

/// version view model
class VersionViewModel {
  var versionRepository = VersionRepository();

  Future getAllVersions() {
    return versionRepository.getVersionCollection();
  }

  Future getSpecificVersion(String id) {
    return versionRepository.getVersionDocument(id);
  }

  Future updateVersion(
      DocumentSnapshot doc, int exVersion, wVersion, tpVersion) {
    return versionRepository.updateVersion(doc, exVersion, wVersion, tpVersion);
  }
}


