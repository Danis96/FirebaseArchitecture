

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  readShared(int versionForReading) async {
    final prefs = await SharedPreferences.getInstance();
    versionForReading = prefs.getInt('exerciseVersion') ?? 0;
    return versionForReading;
  }

  writeShared(int version) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('exerciseVersion', version);
  }






}