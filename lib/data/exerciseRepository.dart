import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/data/contentRepository.dart';
import 'package:firebasedrill/utils/globals.dart';
import 'package:firebasedrill/utils/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseRepository {

//  var db = ContentRepository().db;
  var firestore = Firestore.instance;

  Future getExerciseCollection() async {
    QuerySnapshot qn = await firestore.collection('exercises').getDocuments(
        source: sourceForContent);
    print('get exercise from $sourceForContent');
    return qn.documents;
  }

  Future getExerciseDocument(String id, Source source) async {
    DocumentSnapshot doc = await firestore.document(id).get(source: sourceForContent);
    return doc.data;
  }

  createExercise(String bodyTag, name) async {
    await firestore.collection('exercises').add({
      'bodyTag': bodyTag,
      'name': name,
    });
  }
}
