import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  Syllabary list;
  QuizScreen(Syllabary list) {
    this.list = list;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QuestionCounter(),
            QuestionDisplay(),
            AnswerGrid(),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  BackButton(),
                  SwapCharasButton(),
                  MuteButton(),
                ],
              ),
            ),
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
        columnWidths: {0: FractionColumnWidth(.4), 1: FractionColumnWidth(.4)},
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
      height: 150,
      alignment: Alignment.center,
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
        minWidth: 20,
        height: 120,
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            answer,
            style: Theme.of(context).textTheme.title,
          ),
          onPressed: () {
            if (data.currentQIndex < data.maxQIndex) {
              data.evaluateAnswer(answer);
            } else {
              data.evaluateAnswer(answer);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => Result(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class SwapCharasButton extends StatefulWidget {
  @override
  _SwapCharasButtonState createState() => _SwapCharasButtonState();
}

class _SwapCharasButtonState extends State<SwapCharasButton>
    with TickerProviderStateMixin {
  final Tween<double> turnsTween = Tween<double>(
    begin: 1,
    end: 1.5,
  );

  AnimationController _controller;
  bool first = true;

  initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AppData>(context);
    return RotationTransition(
      turns: turnsTween.animate(_controller),
      child: Container(
        child: RawMaterialButton(
          child: Container(
            child: Icon(
              Icons.swap_vertical_circle,
              color: Theme.of(context).primaryColor,
              size: 60,
            ),
          ),
          onPressed: () {
            if (first) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
            first = !first;
            data.swapGuessChara();
          },
        ),
      ),
    );
  }
}

class QuestionCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    final c = data.currentQIndex;
    final m = data.maxQIndex;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
        ),
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Text(
          "$c / $m",
          style: Theme.of(context).textTheme.button,
        ));
  }
}

class MuteButton extends StatefulWidget {
  bool muted = false;
  @override
  _MuteButtonState createState() => _MuteButtonState();
}

class _MuteButtonState extends State<MuteButton> {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context, listen: false);
    IconData displayIcon = Icons.volume_up;
    if (data.getMuted()) {
      displayIcon = Icons.volume_mute;
    }
    return RawMaterialButton(
      child: Container(
        child: Icon(
          displayIcon,
          color: Theme.of(context).primaryColor,
          size: 60,
        ),
      ),
      onPressed: () {
        data.toggleMuted();
        setState(() {});
      },
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    return RawMaterialButton(
      child: Container(
        child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColor,
          size: 60,
        ),
      ),
      onPressed: () {
        data.resetValues();
        Navigator.popUntil(
          context,
          ModalRoute.withName('/'),
        );
      },
    );
  }
}
