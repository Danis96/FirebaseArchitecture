
import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingPlanRepository {
  var firestore = Firestore.instance;

  Future getTrainingPlanCollection(int version) async {
    QuerySnapshot qn = await firestore
        .collection('trainingPlan')
        .getDocuments(source: version > 1 ? Source.server : Source.cache);
    return qn.documents;
  }

  Future getTrainingPlanDocument(String id, int version) async {
    DocumentSnapshot doc = await firestore.document(id).get(source: version > 1 ? Source.server : Source.cache);
    return doc.data;
  }

  createTrainingPlan(String time, name, workoutID,) async {
    await firestore.collection('trainingPlan').add({
      'time': time,
      'name': name,
      'exercises': [
        {
          'workoutID': workoutID,
        }
      ]
    });
  }
}
