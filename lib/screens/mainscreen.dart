import 'package:flutter/material.dart';
import 'package:hangman_game/models/hangmangame.dart';

import 'gamescreen.dart';

class MainScreen extends StatelessWidget {
  bool areWeInIntegrationTest;

  //take in whether we are in an integration test or not
  MainScreen(this.areWeInIntegrationTest);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff204051),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Hangman",
              style: TextStyle(
                  fontFamily: 'LemonMilk',
                  fontSize: 50,
                  color: Color(0xff84a9ac)),
            ),
            Text(
              "Game",
              style: TextStyle(
                  fontFamily: 'LemonMilk',
                  fontSize: 50,
                  color: Color(0xff84a9ac)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
            ),
            SizedBox(
                height: 100,
                child: Image(image: AssetImage('assets/progress_8.png'))),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            RaisedButton(
              color: Color(0xff84a9ac),
              //Here we are giving the new game button a key for use in our integration tests in test_driver/app_test.dart
              key: Key('new-game-button'),
              child: Text("New Game",
                  style: TextStyle(
                      fontFamily: 'LemonMilkItalic',
                      fontSize: 25,
                      color: Color(0xff204051)),
                  //Here we are giving the new game text field a key for use in our integration tests in test_driver/app_test.dart
                  key: Key('new-game-text')),
              onPressed: () async {
                //when running integration tests instantiate a new HangmanGame where the word is "banana"
                String word =
                    await HangmanGame.getStartingWord(areWeInIntegrationTest);

                HangmanGame game = HangmanGame(word);
                //Push a GameScreen and give it the HangmanGame
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen(game)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
