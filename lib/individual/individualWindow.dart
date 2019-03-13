import 'package:flutter/material.dart';
import 'package:day_time_app/timer.dart';

class IndividualWindow extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Center (
      child: new Column (
        children: <Widget>[
          new Padding (
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child:
              new Text(
                "Wählen sie ihre Zeit aus:",
                style: TextStyle(fontSize: 25, color: Colors.black87),
              ),
          ),
          new Row (
            children: <Widget>[
              //hier eingabe für Stunden Minuten und Sekunden
            ],
          ),
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