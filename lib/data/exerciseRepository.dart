import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseRepository {
  var firestore = Firestore.instance;

  Future getExerciseCollection(int version) async {
    QuerySnapshot qn = await firestore
        .collection('exercises')
        .getDocuments(source: version > 1 ? Source.server : Source.cache);
    return qn.documents;
  }

  Future getExerciseDocument(String id, Source source) async {
    DocumentSnapshot doc = await firestore.document(id).get(source: source);
    return doc.data;
  }

  createExercise(String bodyTag, name) async {
    await firestore.collection('exercises').add({
      'bodyTag': bodyTag,
      'name': name,
    });
  }
}
