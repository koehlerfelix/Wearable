import 'package:flutter/material.dart';


class Hours extends StatefulWidget {

  _HoursState state;

  @override
  _HoursState createState() => state = new _HoursState();

  int getState() {
    /*
    if (state == null) {
      return 1;
    }
    */
    return state.getState();
  }

}

class _HoursState extends State<Hours> {

  int _hour = 0;
  List<int> _hours = new List<int>();

  int getState() {

    return _hour;
  }

  @override
  void initState() {
    _hours.addAll([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
    16, 17 ,18, 19, 20, 21, 22, 23]);
    _hour = _hours.elementAt(0);
  }

  void _onChanged(int value) {
    setState(() {
      _hour = value;
    });
  }
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Text("Stunden:      ", style: TextStyle(fontSize: 40)),
        new DropdownButton(
          value: _hour,
          items: _hours.map((int value) {
            return new DropdownMenuItem(
              value: value,
              child: new Row(
                  children: <Widget>[
                    new Text("${value}", style: TextStyle(fontSize: 40),)
                  ]
              ),
            );
          }).toList(),
          onChanged: (int value) {
            _onChanged(value);
          },
        )
      ],
    );
  }
}

class sixtyButton extends StatefulWidget {
    String info;

    sixtyButton(String info) {
      this.info = info;
    }

  _ButtonState state;

  @override
  _ButtonState createState() => state = new _ButtonState(info);

  int getState() {
    /*
    if (state == null) {
      return 0;
    }
    */
    return state.getState();
  }

}

class _ButtonState extends State<sixtyButton> {
  String info;

  _ButtonState(String info) {
    this.info = info;
  }
  int _value = 0;
  List<int> _values = new List<int>();

  int getState() {
    return _value;
  }

  @override
  void initState() {
    _values.addAll([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
    16, 17 ,18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
    35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
    54, 55, 56, 57, 58, 59]);
    _value = _values.elementAt(0);
  }

  void _onChanged(int value) {
    setState(() {
      _value = value;
    });
  }
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Text("" + info + "   ", style: TextStyle(fontSize: 40)),
        new DropdownButton(
          value: _value,
          items: _values.map((int value) {
            return new DropdownMenuItem(
              value: value,
              child: new Row(
                  children: <Widget>[
                    new Text("${value}", style: TextStyle(fontSize: 40),)
                  ]
              ),
            );
          }).toList(),
          onChanged: (int value) {
            _onChanged(value);
          },
        )
      ],
    );
  }
}

