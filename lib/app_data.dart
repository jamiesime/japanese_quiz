import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

enum Syllabary { Hiragana, Katakana }

// Keeps track of state multiple widgets need access to and handles quiz logic.
class AppData with ChangeNotifier {
  int _maxStreak = 0;
  int _currentStreak = 0;
  Random rnd = new Random();
  Syllabary _syllabary = Syllabary.Hiragana;
  final _hiragana = hiraList;
  final _katakana = kataList;
  bool _guessChara = true;
  Character _currentQuestion = Character("bogus", "bogus");
  List<String> _currentAnswers = List<String>();
  AudioCache audioCache = AudioCache(prefix: 'sound/');

  bool awaitingInput = true;
  int get maxStreak => _maxStreak;
  List<Character> get hiragana => _hiragana;
  List<Character> get katakana => _katakana;

  int getCurrentStreak() => _currentStreak;
  List<String> getCurrentAnswers() => _currentAnswers;

  // Get a question on initialise.
  AppData(Syllabary syllab) {
    this._syllabary = syllab;
    getNextQuestion();
    getNewAnswers(4);
  }

  // Inverts bool to swap guesses/answer from kana to english.
  void swapGuessChara() {
    _guessChara = !_guessChara;
    // Getting the next question on switch, otherwise answers don't refresh + question is the same.
    getNextQuestion();
    getNewAnswers(4);
    notifyListeners();
  }

  void incrementStreak() {
    _maxStreak++;
    notifyListeners();
  }

  String getCurrentQuestion() {
    return _guessChara ? _currentQuestion.chara : _currentQuestion.sound;
  }

  String getNextQuestion() {
    var list = _syllabary == Syllabary.Hiragana ? _hiragana : katakana;
    _currentQuestion = list[rnd.nextInt(list.length)];
    return _guessChara ? _currentQuestion.chara : _currentQuestion.sound;
  }

  void getNewAnswers(int count) {
    List<String> answers = List<String>();
    var list = _syllabary == Syllabary.Hiragana ? _hiragana : katakana;
    for (int i = 0; i < count - 1; i++) {
      if (_guessChara) {
        answers.add(list[rnd.nextInt(list.length)].sound);
      } else {
        answers.add(list[rnd.nextInt(list.length)].chara);
      }
    }
    String correctAnswer =
        _guessChara ? _currentQuestion.sound : _currentQuestion.chara;
    answers.insert(rnd.nextInt(answers.length), correctAnswer);
    _currentAnswers = answers;
  }

  String deepCopyString(String orig) {
    String copy = "";
    for (int i = 0; i < orig.length; i++) {
      copy += orig[i];
    }
    return copy;
  }

  void evaluateAnswer(String answer) {
    if (awaitingInput) {
      awaitingInput = false;
      bool correct = false;
      if (_guessChara) {
        correct = answer == _currentQuestion.sound ? true : false;
      } else {
        correct = answer == _currentQuestion.chara ? true : false;
      }
      // Increments streak and replaces displayed question with x or ✔
      if (correct) {
        audioCache.play('correct.mp3', volume: 0.1);
        _currentStreak++;
        _currentQuestion = _guessChara
            ? Character('✔', _currentQuestion.sound)
            : Character(_currentQuestion.chara, '✔');
      } else {
        _currentStreak = 0;
        _currentQuestion = _guessChara
            ? Character('X', _currentQuestion.sound)
            : Character(_currentQuestion.chara, 'X');
        _currentQuestion = Character('X', 'X');
      }
      notifyListeners();
      nextQuestion();
    }
  }

  void nextQuestion() {
    Future.delayed(Duration(milliseconds: 800), () {
      getNextQuestion();
      getNewAnswers(4);
      notifyListeners();
      awaitingInput = true;
    });
  }
}

// Contains a character and the matching sound.
class Character {
  String chara;
  String sound;

  Character(String newChara, String newSound) {
    this.chara = newChara;
    this.sound = newSound;
  }
  String getChara() {
    return chara;
  }

  String getSound() {
    return sound;
  }
}

// Everything below is just data for the quizzes.
var hiraList = [
  new Character('あ', 'a'),
  new Character('い', 'i'),
  new Character('う', 'u'),
  new Character('え', 'e'),
  new Character('お', 'o'),
  new Character('か', 'ka'),
  new Character('き', 'ki'),
  new Character('く', 'ku'),
  new Character('け', 'ke'),
  new Character('こ', 'ko'),
  new Character('た', 'ta'),
  new Character('ち', 'chi'),
  new Character('つ', 'tsu'),
  new Character('て', 'te'),
  new Character('と', 'to'),
  new Character('さ', 'sa'),
  new Character('し', 'shi'),
  new Character('す', 'su'),
  new Character('せ', 'se'),
  new Character('そ', 'zo'),
  new Character('ば', 'na'),
  new Character('に', 'ni'),
  new Character('ぬ', 'nu'),
  new Character('ね', 'ne'),
  new Character('の', 'no'),
  new Character('は', 'ha'),
  new Character('ひ', 'hi'),
  new Character('ふ', 'hu'),
  new Character('へ', 'he'),
  new Character('ほ', 'ho'),
  new Character('ま', 'ma'),
  new Character('み', 'mi'),
  new Character('む', 'mu'),
  new Character('め', 'me'),
  new Character('も', 'mo'),
  new Character('や', 'ya'),
  new Character('ゆ', 'yu'),
  new Character('よ', 'yo'),
  new Character('ら', 'ra'),
  new Character('り', 'ri'),
  new Character('る', 'ru'),
  new Character('れ', 're'),
  new Character('ろ', 'ro'),
  new Character('わ', 'wa'),
  new Character('を', 'wo'),
  new Character('ん', 'n'),
];

var kataList = [
  new Character('ア', 'a'),
  new Character('イ', 'i'),
  new Character('ウ', 'u'),
  new Character('エ', 'e'),
  new Character('オ', 'o'),
  new Character('カ', 'ka'),
  new Character('キ', 'ki'),
  new Character('ク', 'ku'),
  new Character('ケ', 'ke'),
  new Character('コ', 'ko'),
  new Character('タ', 'ta'),
  new Character('チ', 'chi'),
  new Character('ツ', 'tsu'),
  new Character('テ', 'te'),
  new Character('ト', 'to'),
  new Character('サ', 'sa'),
  new Character('シ', 'shi'),
  new Character('ス', 'su'),
  new Character('セ', 'se'),
  new Character('ゾ', 'zo'),
  new Character('ナ', 'na'),
  new Character('ニ', 'ni'),
  new Character('ヌ', 'nu'),
  new Character('ネ', 'ne'),
  new Character('ノ', 'no'),
  new Character('ハ', 'ha'),
  new Character('ヒ', 'hi'),
  new Character('フ', 'hu'),
  new Character('ヘ', 'he'),
  new Character('ホ', 'ho'),
  new Character('マ', 'ma'),
  new Character('ミ', 'mi'),
  new Character('ム', 'mu'),
  new Character('メ', 'me'),
  new Character('モ', 'mo'),
  new Character('ヤ', 'ya'),
  new Character('ユ', 'yu'),
  new Character('ヨ', 'yo'),
  new Character('ラ', 'ra'),
  new Character('リ', 'ri'),
  new Character('ル', 'ru'),
  new Character('レ', 're'),
  new Character('ロ', 'ro'),
  new Character('ワ', 'wa'),
  new Character('ヲ', 'wo'),
  new Character('ン', 'n'),
];
