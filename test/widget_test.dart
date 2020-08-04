// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hangman_game/models/hangmangame.dart';

import '../lib/screens/gamescreen.dart';

void main() {
  testWidgets('Test The TextField Widget validation for duplicate letters',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    HangmanGame game = HangmanGame('banana');

    //create variables that we will use in this test file by assigning them values from their keys
    final findGuessTextField = find.byKey(Key('guess-textfield'));
    final guessLetterBtnFinder = find.byKey(Key('guess-letter-btn'));

    await tester.pumpWidget(MaterialApp(home: GameScreen(game)));
    expect(find.text('already used that letter'), findsNothing);

    //this is the first guessing of the letter 'b' of the word banana
    await tester.tap(findGuessTextField);
    await tester.enterText(findGuessTextField, 'b');

    await tester.tap(guessLetterBtnFinder);

    await tester.pumpAndSettle(); // let the frames settle

    // try inputing the same letter again and we should expect this to give us an error message
    await tester.tap(findGuessTextField);
    await tester.enterText(findGuessTextField, 'b');

    await tester.tap(guessLetterBtnFinder);

    await tester.pumpAndSettle(); // let the frames settle

    expect(find.text('already used that letter'), findsOneWidget);
  });
}
