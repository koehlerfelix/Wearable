import 'package:flutter/material.dart';
import 'package:day_time_app/calculator/calculationWindow.dart';
import 'package:day_time_app/individual/individualWindow.dart';

void main() => runApp(MaterialApp(
  title: 'UV-Timer',
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
              new Tab(icon: Icon(Icons.laptop_mac)),
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
        new CalculationWindow(),
       // new Counter(),
        new IndividualWindow(),
      ],
    );
  }
}


