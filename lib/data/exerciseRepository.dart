import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/utils/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseRepository {
  var firestore = Firestore.instance;
  var sharedPref = SharedPref();
  int versionFromShared;

  Future getExerciseCollection(int version) async {
    final prefs = await SharedPreferences.getInstance();
    versionFromShared = prefs.getInt('exerciseVersion') ?? 0;
    print('VERSION FROM SHARED PREFS: $versionFromShared');

    QuerySnapshot qn = await firestore.collection('exercises').getDocuments(
        source: version != versionFromShared ? Source.server : Source.cache);
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
