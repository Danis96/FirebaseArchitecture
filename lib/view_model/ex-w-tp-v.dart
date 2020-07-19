import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/data/exerciseRepository.dart';
import 'package:firebasedrill/data/trainingPlanRepository.dart';
import 'package:firebasedrill/data/workoutRepository.dart';


/// exercise view model
class EViewModel {
  var exerciseRepository = ExerciseRepository();

  Future getAllExercises() {
    return exerciseRepository.getExerciseCollection();
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

    Future getAllWorkouts() {
       return workoutRepository.getWorkoutCollection();
    }

    Future getSpecificWorkout(String id, int version) {
       return workoutRepository.getWorkoutDocument(id);
    }

    Future createWorkout(String day, name, exerciseID, time, int reps) {
      return workoutRepository.createWorkout(day, name, exerciseID, time, reps);
    }
}

/// training plan view model
class TrainingPlanViewModel {
    var trainingPlanRepository = TrainingPlanRepository();

    Future getAllTrainingPlans() {
       return trainingPlanRepository.getTrainingPlanCollection();
    }

    Future getSpecificTrainingPlan(String id) {
       return trainingPlanRepository.getTrainingPlanDocument(id);
    }

    Future createTrainingPlan(String time, name, workoutID) {
      return trainingPlanRepository.createTrainingPlan(time, name, workoutID);
    }
}


