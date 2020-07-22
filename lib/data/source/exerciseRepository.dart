import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/data/exerciseModel.dart';
import 'package:firebasedrill/utils/globals.dart';

class ExerciseRepository {
  var firestore = Firestore.instance;

  Future getExerciseCollection() async {
    await firestore
        .collection('exercises')
        .getDocuments(source: Source.cache)
        .then((QuerySnapshot snapshot) => {
              exercises = snapshot.documents
                  .map((e) => ExerciseModel.fromDocument(e))
                  .toList()
            });
  }

  Future getExerciseDocument(String id) async {
    DocumentSnapshot doc =
        await firestore.document(id).get(source: Source.cache);
    return doc.data;
  }
}
