import 'package:flutter/material.dart';

class IndividualWindow extends StatelessWidget {
  Widget build(BuildContext context) {
    Widget build(BuildContext context) {
      return new Center (
        child: new Column (
            children: <Widget>[
              new Align(
                  alignment: Alignment.topLeft,
                  child: new Column(
                    children: <Widget>[
                      new Text(""),
                      new Text(""),
                      new Column(
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 50.0, 0.0),
                                child: new Text("In der Sonne ab: ", style: TextStyle(fontSize: 20.0))
                            ),
                          ]
                      ),
                      //new Result(),
                    ],
                  )
              ),
            ],
          ),
      );
    }
  }
}