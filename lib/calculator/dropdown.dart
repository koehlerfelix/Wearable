import 'package:flutter/material.dart';

class HauttypButton extends StatefulWidget {
  @override
  _State createState() => new _State();
}
class _State extends State<HauttypButton> {

  String _value = null;
  List<String> _values = new List<String>();

  @override
  void initState() {
    _values.addAll(["1", "2", "3"]);
    _value = _values.elementAt(0);
  }

  void _onChanged(String value) {
    setState(() {
      _value = value;
    });
  }

  Widget build(BuildContext context) {
    return new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Row(
                children: <Widget>[
                  new Text("Hauttyp: "),
                  new DropdownButton(
                    value: _value,
                    items: _values.map((String value){
                      return new DropdownMenuItem(
                        value: value,
                        child: new Row(
                            children: <Widget>[
                              new Text("Hauttyp: ${value}")
                            ]
                        ),
                      );
                    }).toList(),
                    onChanged: (String value){_onChanged(value);},
                  ),
                ]
            ),
            new Row(
                children: <Widget>[
                  new Text("Wetter: "),
                  new DropdownButton(
                    value: _value,
                    items: _values.map((String value){
                      return new DropdownMenuItem(
                        value: value,
                        child: new Row(
                            children: <Widget>[
                              new Text("${value}")
                            ]
                        ),
                      );
                    }).toList(),
                    onChanged: (String value){_onChanged(value);},
                  ),
                ]
            ),
            new Row(
                children: <Widget>[
                  new Text("Höhe: "),
                  new DropdownButton(
                    value: _value,
                    items: _values.map((String value){
                      return new DropdownMenuItem(
                        value: value,
                        child: new Row(
                            children: <Widget>[
                              new Text("${value}m")
                            ]
                        ),
                      );
                    }).toList(),
                    onChanged: (String value){_onChanged(value);},
                  ),
                ]
            ),
            new Row(),
            new Row(),
            new Row(),
            new Row(),
          ],
        ));

  }
}

