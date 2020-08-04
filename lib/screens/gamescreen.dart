import 'package:flutter/material.dart';
import 'package:hangman_game/models/hangmangame.dart';

import 'losescreen.dart';
import 'winscreen.dart';

class GameScreen extends StatefulWidget {
  HangmanGame game;
  //This should be modified to take in a HangmanGame
  GameScreen(this.game);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //This will be the controller we use to take in what the user will be guessing
  final guessTextController = TextEditingController();

  //These two variables will be used if there is an issue with the letter the user attempts to guess
  bool alreadyGuessed = false;
  String guessTextFieldErrorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Center(
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    RaisedButton(
                        color: Colors.red,

                        //Here we are giving the guessing button a key for use in our integration tests in test_driver/app_test.dart
                        key: Key('guess-letter-btn'),
                        child:
                            //Here we are giving the letter the user guesses a key for use in our integration tests in test_driver/app_test.dart
                            Text('Guess Letter',
                                style: TextStyle(
                                    fontFamily: 'DroidSans',
                                    fontSize: 16,
                                    color: Color(0xff204051)),
                                key: Key('guess-letter-text')),
                        onPressed: () {
                          setState(() {
                            String userGuess = guessTextController.text;

                            try {
                              //Check to see if the letter the user is guessing has not been guessed already
                              if (widget.game.guess(userGuess)) {
                                alreadyGuessed = false;
                              }
                              //If guess is a repeat, give the user feedback
                              else {
                                alreadyGuessed = true;
                                guessTextFieldErrorMessage =
                                    'already used that letter';
                              }

                              guessTextController.text = '';

                              //Hide the keyboard after guessing
                              FocusScope.of(context).unfocus();

                              //If the user has won the game, renavigate them to the win screen
                              if (widget.game.status == 'win') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WinScreen()));
                              }

                              //If the user has lost the game, renavigate them to the lose screen
                              if (widget.game.status == 'lose') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoseScreen(widget.game)));
                              }
                            } catch (e) {
                              //If the user is guessing an invalid character return this message
                              guessTextFieldErrorMessage = 'invalid';
                              alreadyGuessed = true;
                            }
                          });
                        }),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: TextField(
                          style: TextStyle(
                              fontFamily: 'DroidSans',
                              color: Color(0xff84a9ac)),
                          //Here we are giving the guessing text field a key for use in our integration tests in test_driver/app_test.dart
                          key: Key('guess-textfield'),
                          controller: guessTextController,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontFamily: 'DroidSans',
                                color: Color(0xff84a9ac)),
                            labelText: 'Enter New Letter',
                            errorText: alreadyGuessed
                                ? guessTextFieldErrorMessage
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
                    child: Center(
                        child: Text("Hangman",
                            style: TextStyle(
                                fontSize: 50,
                                fontFamily: "LemonMilk",
                                color: Colors.black)))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                  child: Text('Wrong Guesses: ' + widget.game.wrongGuesses,

                      //Here we are giving the list of wrong guesses a key for use in our integration tests in test_driver/app_test.dart
                      key: Key('wrong-guesses'),
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: "DroidSans",
                          color: Color(0xff84a9ac))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(widget.game.blanksWithCorrectGuesses,

                        //Here we are giving the current progress towards completing the word a key for use in our integration tests in test_driver/app_test.dart
                        key: Key('word-progress'),
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'DroidSans',
                            color: Color(0xff84a9ac))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
