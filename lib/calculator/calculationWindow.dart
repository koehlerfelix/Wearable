import 'package:flutter/material.dart';
import 'dropdown.dart';
import 'package:day_time_app/timer.dart';
import 'package:day_time_app/Setting/connection.dart';

class CalculationWindow extends StatelessWidget {
  HauttypButton h;
  WeatherButton w;
  TimeButton t;
  FlutterBlueApp blue;

  CalculationWindow({this.blue});

  FlutterBlueApp getBlue() {
    return blue;
  }

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
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 50.0, 0.0),
                      child: new Text("In der Sonne ab: ", style: TextStyle(fontSize: 20.0, ))
                    ),
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 65.0, 0.0),
                      child: t = new TimeButton(),
                    ),
                  ]
              ),
              new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 110.0, 0.0),
                        child: new Text("Hauttyp: ", style: TextStyle(fontSize: 20.0))
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
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 110.0, 0.0),
                        child: new Text("Wetter: ", style: TextStyle(fontSize: 20.0))
                    ),
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 35.0, 0.0),
                      child: w = new WeatherButton(),
                    ),
                  ]
              ),
              //new Result(),
            ],
        )
    ),
        new Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 80.0, 21.0, 0.0),
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

  int _minutes = 1;

  void _calculate() {
    setState(() {
      _minutes = calculateResult(calcW);
    });
  }

  int calculateResult(CalculationWindow calcW) {
    int totalMin = 0;
    double mult = 0;
    double hautTypMin = 0;
    switch(calcW.getWeather()) {
      case "sonnig": {mult = 1;}break;
      case "leicht bewölkt": {mult = 1.3;}break;
      default: {mult = 1.8;}break;
    }
    switch(calcW.getTime()) {
      case "10min": {totalMin += 10;}break;
      case "30min": {totalMin += 30;}break;
      case "1h": {totalMin += 60;}break;
      case "2h": {totalMin += 120;}break;
      default: {}break;
    }
    switch(calcW.getHauttyp()) {
      case "sehr hell": {hautTypMin = 10;}break;
      case "hell": {hautTypMin = 20;}break;
      case "normal": {hautTypMin = 30;}break;
      case "bräunlich": {hautTypMin = 90;;}break;
      case "braun": {hautTypMin = 320;}break;
      case "dunkelbraun": {hautTypMin = 1440;}break;
      default: {}break;
    }
    totalMin += (mult * hautTypMin).round();
    if (totalMin > 1440) {
      totalMin = 1440;
    }
    return totalMin;
  }
  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: Alignment.topLeft,
        child: new Column(
          children: <Widget>[
            new Text(
              'Stunden: ${((_minutes / 60) - 0.5).round()}', style: TextStyle(fontSize: 35.0),
            ),
            new Text(
                'Minuten: ${_minutes % 60}', style: TextStyle(fontSize: 35.0),
            ),
            new Text(""),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new MaterialButton(
                  height: 70,
                  minWidth: 140,
                  color: Colors.grey,
                  onPressed: _calculate,
                  child: new Text("Berechnen", style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                new MaterialButton(
                  height: 70,
                  minWidth: 140,
                  color: Colors.grey,
                  onPressed: (){startTimer();},
                  child: new Text("Start", style: TextStyle(color: Colors.white, fontSize: 20)),
                )
              ],
            )
          ],));
  }

  void startTimer() {
    _calculate();
    AlertDialog alert = new AlertDialog(
      content: new Timer(Duration(minutes: _minutes), calcW.getBlue()),
      actions: <Widget>[
        ],
    );
    
    showDialog(context: context, child: alert);
  }

  @override
  bool get wantKeepAlive => true;
}
