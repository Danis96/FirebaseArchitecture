import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/model/exerciseModel.dart';
import 'package:firebasedrill/view_model/ex-w-tp-v.dart';
import 'package:flutter/material.dart';

class ShowExercises extends StatelessWidget {
  final int exVersion;

  ShowExercises({this.exVersion});

  List<dynamic> exercises = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: EViewModel().getAllExercises(exVersion),
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
