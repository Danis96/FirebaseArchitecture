import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingPlanRepository {
  var firestore = Firestore.instance;

  Future getTrainingPlanCollection() async {
    QuerySnapshot qn = await firestore
        .collection('trainingPlan')
        .getDocuments(source: Source.cache);
    return qn.documents;
  }

  Future getTrainingPlanDocument(String id) async {
    DocumentSnapshot doc =
        await firestore.document(id).get(source: Source.cache);
    return doc.data;
  }
}
