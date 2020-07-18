import 'package:cloud_firestore/cloud_firestore.dart';

class VersionModel {
  final int exerciseVersion;
  final int workoutVersion;
  final int trainingPlanVersion;
  VersionModel(
      {this.workoutVersion, this.exerciseVersion, this.trainingPlanVersion});

  factory VersionModel.fromDocument(DocumentSnapshot doc) {
    return VersionModel(
        exerciseVersion: doc['exerciseVersion'],
        trainingPlanVersion: doc['trainingPlanVersion'],
        workoutVersion: doc['workoutVersion']
    );
  }
}
