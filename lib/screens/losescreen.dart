import 'package:flutter/material.dart';
import 'package:hangman_game/models/hangmangame.dart';

import 'gamescreen.dart';

class LoseScreen extends StatelessWidget {
  HangmanGame game;
  //This should be modified to take in a HangmanGame
  LoseScreen(this.game);

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff204051),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Here we are giving the lose game button a key for use in our integration tests in test_driver/app_test.dart
                Text("You Lose",
                    style: TextStyle(
                        fontSize: 50,
                        fontFamily: "LemonMilk",
                        color: Color(0xff84a9ac)),
                    key: Key('lose-game-text')),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                ),
                SizedBox(
                    height: 300,
                    child: Image(image: AssetImage('assets/progress_7.png'))),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                ),
                Text('Your word was: ${game.word}',
                    style: TextStyle(
                        fontFamily: 'DroidSans',
                        fontSize: 25,
                        color: Color(0xff84a9ac))),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                ),
                RaisedButton(
                    color: Color(0xff84a9ac),
                    //Here we are giving the new game button a key for use in our integration tests in test_driver/app_test.dart
                    key: Key('new-game-btn'),
                    child: Text("New Game",
                        style: TextStyle(
                            fontFamily: 'LemonMilkItalic',
                            fontSize: 25,
                            color: Color(0xff204051))),
                    onPressed: () {
                      //instantiate a new HangmanGame where the word is "banana"
                      HangmanGame game = HangmanGame('banana');
                      //Push a GameScreen and give it the HangmanGame
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameScreen(game)),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
