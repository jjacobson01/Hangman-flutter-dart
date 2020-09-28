import 'package:test/test.dart';
import 'package:hangman_game/models/hangmangame.dart';

void main() {
  //This test group will run several tests on the constructor of our hangmanGame class
  group('Test Hangman Constructor', () {
    test('Instance variable word should match word given to constructor', () {
      //make a wacky variable that we will use to pass to the constructor as our word
      String word = 'glorp';
      //pass word to game constructor and create object called hangmanGame
      final hangmanGame = HangmanGame(word);
      //expect that the hangmanGame objects word matches the originally passed word
      expect(hangmanGame.word, word);
    });

    test('Instance variable correct_guess should be empty string initially',
        () {
      //make a wacky variable that we will use to pass to the constructor as our word
      String word = 'glorp';
      //pass word to game constructor and create object called hangmanGame
      final hangmanGame = HangmanGame(word);
      //expect that the game doesn't have any correct guesses since we have not guessed anything yet
      expect(hangmanGame.correctGuesses.isEmpty, isTrue);
    });

    test('Instance variable wrongGuesses should be empty string initially', () {
      //make a wacky variable that we will use to pass to the constructor as our word
      String word = 'glorp';
      //pass word to game constructor and create object called hangmanGame
      final hangmanGame = HangmanGame(word);
      //expect that the game doesn't have any incorrect guesses since we have not guessed anything yet
      expect(hangmanGame.wrongGuesses.isEmpty, isTrue);
    });
  });

  //This test group will run several tests on the way the game should respond to certain guesses
  group('Test Hangman Guessing Behavior', () {
    test('When user guesses correctly', () {
      //make a wacky variable that we will use to pass to the constructor as our word
      String word = 'garply';
      //pass word to game constructor and create object called hangmanGame
      final hangmanGame = HangmanGame(word);

      String letter = 'a';
      //when assigning this boolean variable, the assignment also triggers a guess in our game object
      bool wasAbleToMakeGuess = hangmanGame.guess(letter);
      //check to see if the correct letter was placed in the right list of guesses
      expect(hangmanGame.correctGuesses.contains(letter), isTrue);
      expect(hangmanGame.wrongGuesses.contains(letter), isFalse);
      expect(wasAbleToMakeGuess, isTrue);
    });

    test('When user guess incorrectly', () {
      //make a wacky variable that we will use to pass to the constructor as our word
      String word = 'garply';
      //pass word to game constructor and create object called hangmanGame
      final hangmanGame = HangmanGame(word);

      String letter = 'z';
      //when assigning this boolean variable, the assignment also triggers a guess in our game object
      bool wasAbleToMakeGuess = hangmanGame.guess(letter);

      //check to see if the incorrect letter was placed in the list of wrong guesses
      expect(hangmanGame.correctGuesses.isEmpty, isTrue);
      expect(hangmanGame.wrongGuesses, letter);
      expect(wasAbleToMakeGuess, isTrue);
    });

    test('When user guesses same letter repeatedly (case-insensitive)', () {
      //make a wacky variable that we will use to pass to the constructor as our word
      String word = 'garply';
      //pass word to game constructor and create object called hangmanGame
      final hangmanGame = HangmanGame(word);

      // 'a' and 'q' are guessed for the first time
      hangmanGame.guess('a');
      hangmanGame.guess('q');

      //storing the status of our lists of guesses before repeating the guesses
      String correctGuessesBeforeRepeating = hangmanGame.correctGuesses;
      String wrongGuessesesBeforeRepeating = hangmanGame.wrongGuesses;

      //guess 'a' again
      bool canGuessAagain = hangmanGame.guess('a');
      expect(hangmanGame.correctGuesses, correctGuessesBeforeRepeating);
      expect(canGuessAagain, isFalse);

      // quess 'q' again
      bool canGuessQagain = hangmanGame.guess('q');
      expect(hangmanGame.wrongGuesses, wrongGuessesesBeforeRepeating);
      expect(canGuessQagain, isFalse);

      //guess 'A' again
      bool canGuessCapitalAagain = hangmanGame.guess('A');
      expect(hangmanGame.correctGuesses, correctGuessesBeforeRepeating);
      expect(canGuessCapitalAagain, isFalse);

      //guess 'Q' again
      bool canGuessCapitalQagain = hangmanGame.guess('Q');
      expect(hangmanGame.wrongGuesses, wrongGuessesesBeforeRepeating);
      expect(canGuessCapitalQagain, isFalse);
    });

    //This nested group of tests will run through various invalid character guesses to see how the game responds
    group('Invalid guesses', () {
      test('User tries empty string', () {
        String word = 'foobar';
        final hangmanGame = HangmanGame(word);

        //guess empty string
        expect(() => hangmanGame.guess(''), throwsArgumentError);
      });

      test('User tries non letters (a-zA-Z)', () {
        String word = 'foobar';
        final hangmanGame = HangmanGame(word);

        String nonLetter = '&';
        //guess empty string
        expect(() => hangmanGame.guess(nonLetter), throwsArgumentError);
      });

      test('User tries a null guess', () {
        String word = 'foobar';
        final hangmanGame = HangmanGame(word);

        //guess empty string
        expect(() => hangmanGame.guess(null), throwsArgumentError);
      });
    });
  });

  //This test group will run several tests on the progress we are making towards the word we are guessing
  group('Test Word Progress with Correct Guesses', () {
    test('Word progress with some correct guesses', () {
      //Start a game with the word banana
      String word = 'banana';
      final hangmanGame = HangmanGame(word);
      //Guess two correct letters
      hangmanGame.guess('b');
      hangmanGame.guess('n');
      //We expect the game to return the correct word progress
      String wordProgress = 'b-n-n-';
      expect(hangmanGame.blanksWithCorrectGuesses, wordProgress);
    });

    test('Word with black with all wrong guesses', () {
      //Start a game with the word banana
      String word = 'banana';
      final hangmanGame = HangmanGame(word);
      //Guess three incorrect letters
      hangmanGame.guess('d');
      hangmanGame.guess('e');
      hangmanGame.guess('f');
      //We expect the game to return the correct word progress
      String wordProgress = '------';
      expect(hangmanGame.blanksWithCorrectGuesses, wordProgress);
    });

    test('Word with black all letters guessed', () {
      //Start a game with the word banana
      String word = 'banana';
      final hangmanGame = HangmanGame(word);
      //Guess all the correct letters of the word banana
      hangmanGame.guess('b');
      hangmanGame.guess('a');
      hangmanGame.guess('n');
      //We expect the game to return the correct word progress
      String wordProgress = 'banana';
      expect(hangmanGame.blanksWithCorrectGuesses, wordProgress);
    });
  });

  //This test group will run several tests on
  group('Test Game Status', () {
    test('status returns "win" when all letters guessed', () {
      //Start a game with the word win
      String word = 'win';
      final hangmanGame = HangmanGame(word);
      //Correctly guess all the letters to our word
      hangmanGame.guess('w');
      hangmanGame.guess('i');
      hangmanGame.guess('n');
      //Expect for the game to return a string of 'win' for its status
      expect(hangmanGame.status, 'win');
    });

    test('status to return "lose" after 7 incorrect guesses', () {
      //Start a game with the word xyz
      String word = 'xyz';
      final hangmanGame = HangmanGame(word);
      // makes 7 incorrect guesses
      hangmanGame.guess('a'); // 1
      hangmanGame.guess('b'); // 2
      hangmanGame.guess('c'); // 3
      hangmanGame.guess('d'); // 4
      hangmanGame.guess('e'); // 5
      hangmanGame.guess('f'); // 6
      hangmanGame.guess('g'); // 7
      //Expect for the game to return a string of 'lose' for its status
      expect(hangmanGame.status, 'lose');
    });

    test('status to return "play" if neither win nor lose', () {
      //Start a game with the word play
      String word = 'play';
      final hangmanGame = HangmanGame(word);
      //Expect for the game to return a string of 'play' for its status
      expect(hangmanGame.status, 'play');
      //guess a letter correctly
      hangmanGame.guess('p');
      //Expect for the game to still return a string of 'play' for its status
      expect(hangmanGame.status, 'play');
    });
  });

  group("Starting Word", () {
    test('should be "banana" when integration test flag is on', () async {
      bool areWeInIntegrationTest = true;
      String word = await HangmanGame.getStartingWord(areWeInIntegrationTest);
      expect(word, 'banana');
    });
  });
  group("Scoring", () {
    test('If word is correct, give 10 points', () {
      //Word to start game and test
      String word = 'banana';

      final hangmanGame = HangmanGame(word);
      //test if word is correct
      hangmanGame.guess('b');
      //display 10 points if correct
      expect(hangmanGame.score, 10);
    });
    test('If word is incorrect, give -5 points', () {
      //Word to start game and test
      String word = 'banana';

      final hangmanGame = HangmanGame(word);
      //test if word is incorrect
      hangmanGame.guess('z');
      //display -5 points if incorrect
      expect(hangmanGame.score, -5);
    });
    test('test multiple correct guesses', () {
      //Word to start game and test
      String word = 'game';

      final hangmanGame = HangmanGame(word);
      //test if word is correct multiple times
      hangmanGame.guess('g');
      hangmanGame.guess('e');
      //display 20 points if correct
      expect(hangmanGame.score, 20);
    });
    test('Test multiple incorrect guesses', () {
      //Word to start game and test
      String word = 'game';

      final hangmanGame = HangmanGame(word);
      //test if letters are incorrect
      hangmanGame.guess('b');
      hangmanGame.guess('z');
      //display -10 points for both incorrect guesses
      expect(hangmanGame.score, -10);
    });
    test('Test if multiple guesses are correct and incorrect', () {
      //Word to start game and test
      String word = 'gamers';

      final hangmanGame = HangmanGame(word);
      //consecutive test, 2 correct, 1 incorrect
      hangmanGame.guess('g');
      hangmanGame.guess('a');
      hangmanGame.guess('i');
      //display 15 points, 20 for the correct, and -5 for the incorrect
      expect(hangmanGame.score, 15);
    });
    test('Test if there is more than 1 letter of the guessed letter', () {
      //Word to start game and test
      String word = 'bananas';

      final hangmanGame = HangmanGame(word);
      //test if letter is correct 
      hangmanGame.guess('a');
      //display 30 points for word having 3 'a's
      expect(hangmanGame.score, 30);
    });
  });
}
