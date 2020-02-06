import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 50),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline,
                children: [
                  TextSpan(text: "kana"),
                  TextSpan(
                      text: "rama",
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Antipasto',
                          fontSize: 60)),
                ],
              ),
            ),

            // Text("kanarama", style: Theme.of(context).textTheme.display1),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
    AppData data = Provider.of(context, listen: false);
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        margin: EdgeInsets.all(5),
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(28.0),
              side: BorderSide(color: Colors.black)),
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
          child: Text(
            text,
            style: Theme.of(context).textTheme.body1,
          ),
          onPressed: () {
            data.startQuiz(quizType);
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => QuizScreen(quizType),
              ),
            );
          },
        ),
      ),
    );
  }
}
