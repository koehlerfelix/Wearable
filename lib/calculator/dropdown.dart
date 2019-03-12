import 'package:flutter/material.dart';

class HauttypButton extends StatefulWidget {
  @override
  _HauttypState createState() => new _HauttypState();
}
class _HauttypState extends State<HauttypButton>  {

  String _value = "";
  List<String> _values = new List<String>();

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
  @override
  _WeatherState createState() => new _WeatherState();
}
class _WeatherState extends State<WeatherButton> {

  String _value = "";
  List<String> _values = new List<String>();

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
  @override
  _TimeState createState() => new _TimeState();
}
class _TimeState extends State<TimeButton>
    with AutomaticKeepAliveClientMixin<TimeButton>{

  String _value = "";
  List<String> _values = new List<String>();

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



