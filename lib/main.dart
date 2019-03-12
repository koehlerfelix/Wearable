import 'package:flutter/material.dart';
import 'package:day_time_app/individual/counter.dart';
import 'package:day_time_app/calculator/dropdown.dart';
//import 'package:flutter_blue/flutter_blue.dart';

void main() => runApp(MaterialApp(
  title: 'UV-meassure',
  home: new Home(),
));

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("UV-Timer"),
          backgroundColor: Colors.green,
          bottom: new TabBar(
            tabs: <Widget>[
              new Tab(icon: Icon(Icons.brightness_2)),
              new Tab(text: "Individueller Timer"),
            ],
          ),
        ),
        body: new MyTabBarView(),
      ),
    );
  }
}

class MyTabBarView extends StatelessWidget {
  Widget build(BuildContext context) {
    return new TabBarView(
      children: <Widget>[
        new HauttypButton(),
        new Counter(),
      ],
    );
  }
}


