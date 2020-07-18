import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingPlanModel {
   final String name,time;
   final List<dynamic> workouts;

   TrainingPlanModel({this.name, this.time, this.workouts});

   factory TrainingPlanModel.fromDocument(DocumentSnapshot doc) {
      return TrainingPlanModel(
        name: doc['name'],
        time: doc['time'],
        workouts: doc['workouts']
      );
   }
}