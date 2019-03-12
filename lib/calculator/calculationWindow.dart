import 'package:flutter/material.dart';
import 'dropdown.dart';

class CalculationWindow extends StatelessWidget {
  HauttypButton h;
  WeatherButton w;
  TimeButton t;

  String getHauttyp() {
    return h.getState();
  }

  String getWeather() {
    return w.getState();
  }

  String getTime() {
    return t.getState();
  }

  Widget build(BuildContext context) {
    return new Column (
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
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
                      child: new Text("In der Sonne ab: "),
                    ),
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
                      child: t = new TimeButton(),
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
                      child: h = new HauttypButton(),
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
                      child: w = new WeatherButton(),
                    ),
                  ]
              ),
              //new Result(),
            ],
        )
    ),
        new Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 200.0, 21.0, 0.0),
          child: new Result(
            calculationWindow: this,
          ),
        )

    ],
    );
  }
}

class Result extends StatefulWidget {
  CalculationWindow calculationWindow;

  Result({this.calculationWindow});

  @override
  _ResultState createState() => _ResultState(calcW: calculationWindow);


}

class _ResultState extends State<Result>
    with AutomaticKeepAliveClientMixin<Result> {

  CalculationWindow calcW;
  _ResultState({this.calcW});

  int _minutes = 0;
  String state1 = "";
  String state2 = "";
  String state3 = "";

  void _calculate() {
    setState(() {
      ++_minutes;
      state1 = calcW.getTime();
      state2 = calcW.getHauttyp();
      state3 = calcW.getWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: Alignment.topLeft,
        child: new Column(
          children: <Widget>[
            new Text(
                'Minuten: $_minutes'
            ),
            new Text (
                'Ab: $state1'
            ),
            new Text (
                'Typ: $state2'
            ),
            new Text (
                'Wetter: $state3'
            ),
            new RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: _calculate,
              child: new Text("Berechnen", style: TextStyle(color: Colors.white)),
            )
          ],));
  }

  @override
  bool get wantKeepAlive => true;
}
