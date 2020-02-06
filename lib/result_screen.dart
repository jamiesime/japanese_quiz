import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_quiz/main_menu.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context, listen: false);
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Drill complete!',
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.center,
            ),
            Text(
              "Score: " +
                  data.correctAnswers.toString() +
                  "/" +
                  data.maxQIndex.toString(),
              style: Theme.of(context).textTheme.body2,
            ),
            Divider(
              height: 50,
            ),
            RaisedButton(
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Return',
                style: Theme.of(context).textTheme.body1,
              ),
              onPressed: () {
                // Resets the quiz values and returns to the home screen.
                data.resetValues();
                Navigator.popUntil(
                  context,
                  ModalRoute.withName("/"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
