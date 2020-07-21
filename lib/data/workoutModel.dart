import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutModel {
   final String name, day;
   final List<dynamic> exercises;

   WorkoutModel({this.name, this.exercises, this.day});


   factory WorkoutModel.fromDocument(DocumentSnapshot doc) {
      return WorkoutModel(
        name: doc['name'],
        day: doc['day'],
        exercises: doc['exercises']
      );
   }
}