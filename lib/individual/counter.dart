import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter>
    with AutomaticKeepAliveClientMixin<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  void _decrement() {
    setState(() {
      --_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(),
            new CounterDisplay(count: _counter),
            new Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new ChangeCounterButton(upDown: "--", onPressed: _decrement),
                    new ChangeCounterButton(upDown: "++", onPressed: _increment),
                  ]),
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class CounterDisplay extends StatelessWidget {

  final int count;

  //Konstruktor mit named Parameter
  CounterDisplay({this.count});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Counter: $count',
      style: TextStyle(fontSize: 25.0),
    );
  }
}

class ChangeCounterButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String upDown;

  //Konstruktor mit named Parameter
  ChangeCounterButton({this.upDown, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      onPressed: onPressed,
      child: new Text(upDown, style: TextStyle(color: Colors.white)),
    );
  }
}