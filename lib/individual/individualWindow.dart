import 'package:flutter/material.dart';
import 'package:day_time_app/timer.dart';
import 'timeInput.dart';
import 'package:day_time_app/Setting/connection.dart';

class IndividualWindow extends StatelessWidget {
  Hours h;
  sixtyButton m;
  sixtyButton s;
  FlutterBlueApp blue;

  IndividualWindow({this.blue});

  FlutterBlueApp getBlue() {
    return blue;
  }

  int getHours() {
    return h.getState();
  }

  int getMinutes() {
    return m.getState();
  }

  int getSeconds() {
    return s.getState();
  }

  Widget build(BuildContext context) {
    return new Center (
      child: new Column (
        children: <Widget>[
          new Padding (
            padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
            child:
              new Text(
                "Wählen sie ihren Timer aus:",
                style: TextStyle(fontSize: 25, color: Colors.black87),
              ),
          ),
          new Padding(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child:
                new Column (
                  children: <Widget>[
                    //hier eingabe für Stunden Minuten und Sekunden
                    h = new Hours(),
                    m = new sixtyButton("Minuten:   "),
                    s = new sixtyButton("Sekunden:")
                  ],
                ),
          ),
          new Padding(
             padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child:
                new MaterialButton(
                  height: 70,
                  minWidth: 200,
                  color: Colors.grey,
                  onPressed: () {
                    show(context);
                  },
                  child: new Text("Start", style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
          ),
        ]
      ),
    );//new Result(),
  }
  show(BuildContext context) {
    AlertDialog alert = new AlertDialog(
      content: new Timer(Duration(
          seconds: s.getState(), minutes: m.getState(), hours: h.getState()), blue),
      actions: <Widget>[
      ],
    );

    showDialog(context: context, child: alert);
  }
}