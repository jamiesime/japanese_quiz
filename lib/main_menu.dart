import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'app_data.dart';
import 'quiz_screen.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: <Widget>[
                Text(
                  "Welcome",
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              MainMenuButton('Hiragana', Syllabary.Hiragana),
              MainMenuButton('Katakana', Syllabary.Katakana),
            ],
          ),
        ],
      ),
    );
  }
}

class MainMenuButton extends StatelessWidget {
  String text;
  Syllabary quizType;

  MainMenuButton(String text, Syllabary quiz) {
    this.text = text;
    this.quizType = quiz;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: FlatButton(
        color: Theme.of(context).accentColor,
        padding: EdgeInsets.all(20),
        child: Text(
          text,
          style: Theme.of(context).textTheme.body1,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScreen(quizType),
            ),
          );
        },
      ),
    );
  }
}
