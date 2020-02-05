import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';

class QuizScreen extends StatelessWidget {
  Syllabary list;

  QuizScreen(Syllabary list) {
    this.list = list;
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppData(list),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QuestionDisplay(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SwapCharasButton(),
                StreakCounter(),
              ],
            ),
            AnswerGrid(),
          ],
        ),
      ),
    );
  }
}

class AnswerGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    List<String> answers = data.getCurrentAnswers();
    return Container(
      child: Table(
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              AnswerButton(answers[0]),
              AnswerButton(answers[1]),
            ],
          ),
          TableRow(
            children: <Widget>[
              AnswerButton(answers[2]),
              AnswerButton(answers[3]),
            ],
          ),
        ],
      ),
    );
  }
}

class QuestionDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Consumer<AppData>(
        builder: (_, data, __) => Text(data.getCurrentQuestion(),
            style: Theme.of(context).textTheme.headline),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  String answer;

  AnswerButton(String ans) {
    this.answer = ans;
  }
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context, listen: false);
    return Container(
      margin: EdgeInsets.all(5),
      child: ButtonTheme(
        minWidth: 120,
        height: 120,
        padding: EdgeInsets.all(20),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            answer,
            style: Theme.of(context).textTheme.title,
          ),
          onPressed: () {
            data.evaluateAnswer(answer);
          },
        ),
      ),
    );
  }
}

class SwapCharasButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context);
    return Container(
      child: FlatButton(
        padding: EdgeInsets.all(30),
        child: Icon(
          Icons.swap_vertical_circle,
          color: Theme.of(context).primaryColor,
          size: 60,
        ),
        onPressed: () {
          data.swapGuessChara();
        },
      ),
    );
  }
}

class StreakCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Theme.of(context).primaryColor,
      child: Consumer<AppData>(
        builder: (_, data, __) => (Text(
          data.getCurrentStreak().toString(),
          style: Theme.of(context).textTheme.body1,
        )),
      ),
    );
  }
}
