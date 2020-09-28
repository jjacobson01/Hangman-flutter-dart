import 'package:http/http.dart' as http;

class HangmanGame {
  String word;
  String correctGuesses;
  String wrongGuesses;
  int score = 0;

  //Constructor starts off with blank strings that we will concatenate during the course of play
  HangmanGame(this.word) {
    correctGuesses = "";
    wrongGuesses = "";
  }

  bool guess(String letter) {
    //This tests if the letter passed as a guess by the user is a valid alphanumeric character through the use of regular expressions
    RegExp test = new RegExp(r'[a-zA-Z]');

    if (letter == null || letter == "" || !test.hasMatch(letter)) {
      throw ArgumentError();
    }
    //ADD SCORE SYSTEM
    //We want for our guesses to be case insensitive
    letter = letter.toLowerCase();

    if (word.contains(letter)) {
      //return false if not part of alphabet
      if (correctGuesses.contains(letter)) {
        return false;
      }
      //means letter is correct, add 10 point system
      correctGuesses += letter;
      for(int i = 0; i < word.length;++i)
      {
        if(word[i]==letter)
        {
          score += 10;
        }
      }
      return true;
    } else {
      //same as above, checks if part of alphabet
      if (wrongGuesses.contains(letter)) {
        return false;
      }
      //means letter is not in word, minus 5 point system
      wrongGuesses += letter;
      score-=5;
      return true;
    }
  }

  String gameBlanksWithCorrectGuesses() {
    String tmp = "";
    for (int a = 0; a < word.length; a++) {
      if (correctGuesses.contains(word[a])) {
        tmp += word[a];
      } else {
        tmp += "-";
      }
    }
    return tmp;
  }

  String get status {
    return gameStatus();
  }

  String get blanksWithCorrectGuesses {
    return gameBlanksWithCorrectGuesses();
  }

  String gameStatus() {
    String status = gameBlanksWithCorrectGuesses();
    if (wrongGuesses.length >= 7) {
      return "lose";
    } else if (status == word) {
      return "win";
    } else {
      return "play";
    }
  }

  //when running integration tests always return "banana"
  static Future<String> getStartingWord(bool areWeInIntegrationTest) async {
    String word;

    if (areWeInIntegrationTest) {
      word = "banana";
    } else {
      try {
        var response = await http
            .post("http://watchout4snakes.com/wo4snakes/Random/RandomWord");
        word = response.body;
      } catch (e) {
        word = "error";
      }
    }

    return word;
  }
}
