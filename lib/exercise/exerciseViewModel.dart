import 'package:firebasedrill/data/source/exerciseRepository.dart';

class EViewModel {
  var exerciseRepository = ExerciseRepository();

  Future getAllExercises() {
    return exerciseRepository.getExerciseCollection();
  }

  Future getSpecificExercise(String id) {
    return exerciseRepository.getExerciseDocument(id);
  }
}