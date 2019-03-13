import 'package:flutter/material.dart';
import 'package:day_time_app/timer.dart';

class IndividualWindow extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Center (
      child: new Column (
        children: <Widget>[
          new MaterialButton(
            height: 70,
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Timer(Duration(seconds: 5))),
              );
            },
            child: new Text("Start", style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ]
      ),
    );//new Result(),
  }
}