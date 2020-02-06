import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Text('Drill complete!', style: Theme.of(context).textTheme.title),
          Text(
            "Score: " +
                data.correctAnswers.toString() +
                "/" +
                data.maxQIndex.toString(),
            style: Theme.of(context).textTheme.body1,
          ),
        ],
      ),
    );
  }
}
