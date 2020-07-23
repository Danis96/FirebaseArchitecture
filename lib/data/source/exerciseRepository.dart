import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/data/exerciseModel.dart';

class ExerciseRepository {
  var firestore = Firestore.instance;


  Future getExerciseModel() async {
    QuerySnapshot qn = await firestore
        .collection('exercises')
        .getDocuments(source: Source.cache);
    return qn.documents;
  }


  Future getExerciseDocument(String id) async {
    DocumentSnapshot doc =
        await firestore.document(id).get(source: Source.cache);
    return doc.data;
  }
}
