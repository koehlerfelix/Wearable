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
            //new Result(),
          ],
        )
    );
  }
}

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result>
    with AutomaticKeepAliveClientMixin<Result> {

  int _minutes = 0;

  void _calculate() {
    setState(() {
      ++_minutes;
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

class CalculateResultButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String upDown;

  //Konstruktor mit named Parameter
  CalculateResultButton({this.upDown, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: onPressed,
      child: new Text(upDown, style: TextStyle(color: Colors.white)),
    );
  }
}