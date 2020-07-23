import 'dart:async';

import 'package:firebasedrill/data/source/contentRepository.dart';
import 'package:firebasedrill/data/source/exerciseRepository.dart';
import 'package:firebasedrill/showExercise/exerciseEvents.dart';

class ShowExerciseViewModel {
  var contentRepository = ContentRepository();
  var exerciseRepository = ExerciseRepository();

  List<dynamic> exercises = [];

  /// state
  final _exerciseStateController = StreamController();
  StreamSink get _inExercise => _exerciseStateController.sink;
  Stream get exercise => _exerciseStateController.stream;

  /// event listener
  final _exerciseEventController = StreamController<ExerciseEvents>();
  Sink<ExerciseEvents> get exerciseEventSink => _exerciseEventController.sink;


  ShowExerciseViewModel() {
     _exerciseEventController.stream.listen(_mapExerciseToState);
  }

  void _mapExerciseToState(ExerciseEvents event) async {
     if(event is GetExerciseModelEvent) {
       exercises = await exerciseRepository.getExerciseModel();
       print(exercises);
       _inExercise.add(exercises);
     }
  }

  void dispose() {
    _exerciseEventController.close();
    _exerciseStateController.close();
  }

  start() {
    contentRepository.checkVersion();
  }

}
