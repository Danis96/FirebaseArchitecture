import 'package:firebasedrill/data/source/workoutRepository.dart';

class WorkoutViewModel {
  var workoutRepository = WorkoutRepository();

  Future getAllWorkouts() {
    return workoutRepository.getWorkoutCollection();
  }

  Future getSpecificWorkout(String id) {
    return workoutRepository.getWorkoutDocument(id);
  }
}