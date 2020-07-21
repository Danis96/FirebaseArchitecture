import 'dart:async';
import 'package:firebasedrill/data/exerciseModel.dart';
import 'package:firebasedrill/exercise/exerciseViewModel.dart';
import 'package:firebasedrill/showExerciseWidget/showExerciseViewModel.dart';
import 'package:flutter/material.dart';

var showExerciseViewModel = ShowExerciseViewModel();

class ShowExercises extends StatefulWidget {
  @override
  _ShowExercisesState createState() => _ShowExercisesState();
}

class _ShowExercisesState extends State<ShowExercises> {
  List<dynamic> exercises = [];

  @override
  void initState() {
    super.initState();
    showExerciseViewModel.checkContentVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(seconds: 1)).then(
                    (value) => EViewModel().getAllExercises()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                exercises = snapshot.data
                    .map((exer) => ExerciseModel.fromDocument(exer))
                    .toList();
                return ListView.builder(
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
                    });
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
