import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/data/workoutModel.dart';
import 'package:firebasedrill/utils/globals.dart';

class WorkoutRepository {
  var firestore = Firestore.instance;

  Future getWorkoutCollection() async {
    await firestore
        .collection('workouts')
        .getDocuments(source: Source.cache)
        .then((QuerySnapshot snapshot) => {
              workouts = snapshot.documents
                  .map((e) => WorkoutModel.fromDocument(e))
                  .toList()
            });
  }

  Future getWorkoutDocument(String id) async {
    DocumentSnapshot doc =
        await firestore.document(id).get(source: Source.cache);
    return doc.data;
  }
}
