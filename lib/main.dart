import 'package:flutter/material.dart';
import 'package:hangman_game/screens/mainscreen.dart';

//this "areWeInIntegrationTest" boolean value is going to get passed down alot
//what it is, is that it is used to tell it when we are running integration tests
//we need this because we need to make it have a specific word for testing so that
//we can properly know what the right answer is supposed to be after we do certain operations
//by default this value is false
void main({areWeInIntegrationTest = false}) =>
    runApp(MyApp(areWeInIntegrationTest));

class MyApp extends StatelessWidget {
  bool areWeInIntegrationTest;

  //take in whether or not we are in an integration test or not
  MyApp(this.areWeInIntegrationTest);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //pass down whether we are in an integration test or not
      home: MainScreen(areWeInIntegrationTest),
    );
  }
}
