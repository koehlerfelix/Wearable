import 'package:flutter/material.dart';
import 'dropdown.dart';

class CalculationWindow extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Align(
        alignment: Alignment.topLeft,
        child: new Column(
          children: <Widget>[
            new Text(""),
            new Text(""),
            new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
                    child: new Text("In der Sonne ab: "),
                  ),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
                    child: new TimeButton(),
                  ),
                ]
            ),
            new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
                    child:  new Text("Hauttyp: "),
                  ),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 21.0, 0.0),
                    child: new HauttypButton(),
                  ),
                ]
            ),
            new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
                    child:  new Text("Wetter: "),
                  ),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0.0, 21.0, 0.0),
                    child: new WeatherButton(),
                  ),
                ]
            ),
          ],
        )
    );
  }
}