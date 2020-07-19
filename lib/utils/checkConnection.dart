

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'globals.dart';

class InternetConnectivity {
  checkForConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

}