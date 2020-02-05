import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'app_data.dart';
import 'quiz_screen.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            alignment: Alignment.topCenter,
            child: Text("kanarama",
                style: Theme.of(context).textTheme.display1),
          ),
          Divider(height: 390,),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Row(
              children: <Widget>[
                MainMenuButton('Hiragana', Syllabary.Hiragana),
                MainMenuButton('Katakana', Syllabary.Katakana),
              ],
            ),
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
      margin: EdgeInsets.all(5),
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.fromLTRB(10,30,10,30),
        child: Text(
          text,
          style: Theme.of(context).textTheme.body1,
        ),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => QuizScreen(quizType),
            ),
          );
        },
      ),
    );
  }
}
