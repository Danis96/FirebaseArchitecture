import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/data/trainingPlanModel.dart';
import 'package:firebasedrill/utils/globals.dart';

class TrainingPlanRepository {
  var firestore = Firestore.instance;

  Future getTrainingPlanCollection() async {
    await firestore
        .collection('trainingPlan')
        .getDocuments(source: Source.cache)
        .then((QuerySnapshot snapshot) => {
              trainingPlan = snapshot.documents
                  .map((e) => TrainingPlanModel.fromDocument(e))
                  .toList()
            });
  }

  Future getTrainingPlanDocument(String id) async {
    DocumentSnapshot doc =
        await firestore.document(id).get(source: Source.cache);
    return doc.data;
  }
}
