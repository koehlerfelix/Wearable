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
        backgroundColor: Colors.amber,

        appBar: new AppBar(
          title: new Text(
              "UV-Timer",style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          bottom: new TabBar(
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.black87,
            indicatorColor: Colors.amber,
            tabs: <Widget>[
              new Tab(icon: Icon(Icons.laptop_mac)),
              new Tab(text: "Individueller Timer"),
            ],
          ),
        ),
        body:
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.01, 0.15, 0.5, 0.9],
                colors: [
                  Colors.white,
                  Colors.limeAccent,
                  Colors.amberAccent,
                  Colors.amber,
                ],
              )
            ),
            child: new MyTabBarView() ,
          )
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


