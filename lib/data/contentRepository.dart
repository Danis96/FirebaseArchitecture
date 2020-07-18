import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedrill/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentRepository {
  static final ContentRepository _dbHelper = ContentRepository._internal();

  ContentRepository._internal();

  factory ContentRepository() {
    return _dbHelper;
  }

  static Firestore _db;

  Future<Firestore> get db async {
    if (_db == null) {
      _db = await Firestore.instance;
    }
    return _db;
  }

  checkVersion() async {
    Firestore db = await this.db;

    /// lokalna verzija
    int versionFromShared;
    final prefs = await SharedPreferences.getInstance();
    versionFromShared = prefs.getInt('exerciseVersion') ?? 0;
    print('VERSION FROM SHARED PREFS: $versionFromShared');

    /// server verzija
    int versionFromServer;
    DocumentSnapshot qn = await db
        .collection('versions')
        .document('bsjRzcG4O8PEi3Dq0BbB')
        .get(source: Source.serverAndCache)
        .then((value) {
      value.data.forEach((key, value) {
        versionFromServer = value[0]['version'];
      });
      return;
    });
    print('VERSION FROM server : $versionFromServer');

    /// provjera - odakle cu uzimati content
    if (versionFromServer != versionFromShared) {
      print('Razlicite su verzije i skidam novi kontent');
      sourceForContent = Source.server;
    } else {
      print('Verzije su iste, kontent iz cache');
      sourceForContent = Source.cache;
    }
  }
}
