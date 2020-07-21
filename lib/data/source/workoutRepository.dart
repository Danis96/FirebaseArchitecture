
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutRepository {
  var firestore = Firestore.instance;

  Future getWorkoutCollection() async {
    QuerySnapshot qn = await firestore
        .collection('workouts')
        .getDocuments(source: Source.cache);
    return qn.documents;
  }

  Future getWorkoutDocument(String id) async {
    DocumentSnapshot doc = await firestore.document(id).get(source: Source.cache);
    return doc.data;
  }
}
