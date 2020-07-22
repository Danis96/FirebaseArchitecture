import 'dart:async';

import 'package:firebasedrill/showExerciseWidget/showExerciseViewModel.dart';
import 'package:firebasedrill/utils/globals.dart';
import 'package:flutter/material.dart';

var showExerciseViewModel = ShowExerciseViewModel();

class ShowExercises extends StatefulWidget {
  @override
  _ShowExercisesState createState() => _ShowExercisesState();
}

class _ShowExercisesState extends State<ShowExercises> {
  @override
  void initState() {
    super.initState();
    showExerciseViewModel.checkContentVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: exercises.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text((index + 1).toString() +
                        '. ' +
                        exercises[index].name +
                        '  (' +
                        exercises[index].bodyTag +
                        ')'),
                  )
                ],
              );
            }));
  }
}
