import 'package:firebasedrill/model/versionModel.dart';
import 'package:firebasedrill/utils/checkConnection.dart';
import 'package:firebasedrill/utils/sharedPref.dart';
import 'package:firebasedrill/view/showExercise.dart';
import 'package:firebasedrill/view_model/ex-w-tp-v.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    InternetConnectivity().checkForConnectivity();
  }

  List<dynamic> versions = [];
  int exVersion, exPrefVersion;
  var sharedPref = SharedPref();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child:
        FutureBuilder(
            future: VersionViewModel().getAllVersions(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                versions = snapshot.data
                    .map((ver) => VersionModel.fromDocument(ver))
                    .toList();
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: versions.length,
                    itemBuilder: (BuildContext context, int index) {
                      exVersion = versions[index].exerciseVersion;
                      sharedPref.writeShared(exVersion);
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text('Exercise Version : ' +
                                  versions[index].exerciseVersion.toString()),
                            ),
                            ShowExercises(
                              exVersion: exVersion,
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}


