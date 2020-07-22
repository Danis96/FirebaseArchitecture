

import 'dart:async';

import 'package:firebasedrill/data/source/contentRepository.dart';

class ShowExerciseViewModel {

  var contentRepository = ContentRepository();

  checkContentVersion() {
    contentRepository.checkVersion();
  }

}