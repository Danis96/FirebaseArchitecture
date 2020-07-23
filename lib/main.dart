import 'package:firebasedrill/showExercise/showExerciseView.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: Text('Firebase Drill'),
          centerTitle: true,
        ),
        body: Center(child: ShowExercises())
      ),
    );
  }
}
