import 'dart:async';

import 'package:firebasedrill/showExercise/exerciseEvents.dart';
import 'package:firebasedrill/showExercise/showExerciseViewModel.dart';
import 'package:flutter/material.dart';

var showExerciseViewModel = ShowExerciseViewModel();

class ShowExercises extends StatefulWidget {
  @override
  _ShowExercisesState createState() => _ShowExercisesState();
}

class _ShowExercisesState extends State<ShowExercises> {
  final _bloc = ShowExerciseViewModel();

  @override
  void initState() {
    super.initState();
    showExerciseViewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    _bloc.exerciseEventSink.add(GetExerciseModelEvent());
    return Container(
      child: StreamBuilder(
          initialData: [],
          stream: _bloc.exercise,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
                itemCount: _bloc.exercises.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Container(
                      child: Text(snapshot.data[index].data['name']),
                    ),
                  );
                });
          }),
    );
  }
}
