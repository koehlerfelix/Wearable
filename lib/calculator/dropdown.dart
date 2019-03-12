import 'package:flutter/material.dart';


class HauttypButton extends StatefulWidget {
  _HauttypState state;

  @override
  _HauttypState createState() => state = new _HauttypState();

  String getState() {
    return state.getState();
  }

}
class _HauttypState extends State<HauttypButton>  {

  String _value = "";
  List<String> _values = new List<String>();

  String getState() {
    return _value;
  }

  @override
  void initState() {
    _values.addAll(["sehr hell", "hell", "normal", "bräunlich", "braun", "sehr braun"]);
    _value = _values.elementAt(0);
  }

  void _onChanged(String value) {
    setState(() {
      _value = value;
    });
  }

  Widget build(BuildContext context) {
    return new DropdownButton(
      value: _value,
      items: _values.map((String value) {
        return new DropdownMenuItem(
          value: value,
          child: new Row(
              children: <Widget>[
                new Text("${value}")
              ]
          ),
        );
      }).toList(),
      onChanged: (String value) {
        _onChanged(value);
      },
    );
  }
}


class WeatherButton extends StatefulWidget {
  _WeatherState state;

  @override
  _WeatherState createState() => state = new _WeatherState();

  String getState() {
    return state.getState();
  }
}
class _WeatherState extends State<WeatherButton> {

  String _value = "";
  List<String> _values = new List<String>();

  String getState() {
    return _value;
  }

  @override
  void initState() {
    _values.addAll(["sonnig", "leicht bewölkt", "bewölkt"]);
    _value = _values.elementAt(0);
  }

  void _onChanged(String value) {
    setState(() {
      _value = value;
    });
  }

  Widget build(BuildContext context) {
    return new DropdownButton(
      value: _value,
      items: _values.map((String value) {
        return new DropdownMenuItem(
          value: value,
          child: new Row(
              children: <Widget>[
                new Text("${value}")
              ]
          ),
        );
      }).toList(),
      onChanged: (String value) {
        _onChanged(value);
      },
    );
  }
}

class TimeButton extends StatefulWidget {
  _TimeState state;

  @override
  _TimeState createState() => state = new _TimeState();

  String getState() {
    return state.getState();
  }
}
class _TimeState extends State<TimeButton>
    with AutomaticKeepAliveClientMixin<TimeButton>{

  String _value = "";
  List<String> _values = new List<String>();

  String getState() {
    return _value;
  }

  @override
  void initState() {
    _values.addAll(["jetzt", "10min", "30min", "1h", "2h"]);
    _value = _values.elementAt(0);
  }

  void _onChanged(String value) {
    setState(() {
      _value = value;
    });
  }

  Widget build(BuildContext context) {
    return new DropdownButton(

      value: _value,
      items: _values.map((String value) {
        return new DropdownMenuItem(
          value: value,
          child: new Row(
              children: <Widget>[
                new Text("${value}")
              ]
          ),
        );
      }).toList(),
      onChanged: (String value) {
        _onChanged(value);
      },
    );
  }
  @override
  bool get wantKeepAlive => true;
}



