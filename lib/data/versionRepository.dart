import 'package:cloud_firestore/cloud_firestore.dart';

class VersionRepository {

  var firestore = Firestore.instance;

  Future getVersionCollection() async {
    QuerySnapshot qn =
        await firestore.collection('versions').getDocuments(source: Source.serverAndCache);
    return qn.documents;
  }

  Future getVersionDocument(String id) async {
    DocumentSnapshot doc = await firestore.document(id).get(source: Source.serverAndCache);
    return doc.data;
  }

  updateVersion(
      DocumentSnapshot doc, int exVersion, wVersion, tpVersion) async {
    await firestore
        .collection('versions')
        .document(doc.documentID)
        .updateData({
      'exerciseVersion': exVersion,
      'workoutVersion': wVersion,
      'trainingPlanVersion': tpVersion,
    });
  }
}
