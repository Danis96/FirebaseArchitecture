import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseModel {
   final String bodyTag;
   final String name;

   ExerciseModel({this.bodyTag, this.name});

   factory ExerciseModel.fromDocument(DocumentSnapshot doc) {
     return ExerciseModel(
       bodyTag: doc['bodyTag'],
       name: doc['name'],
     );
   }
}