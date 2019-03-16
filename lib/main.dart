import 'package:flutter/material.dart';
import 'package:day_time_app/calculator/calculationWindow.dart';
import 'package:day_time_app/individual/individualWindow.dart';
import 'package:day_time_app/Setting/counter.dart';
import 'package:day_time_app/Setting/connection.dart';


void main() => runApp(MaterialApp(
  title: 'UV-Timer',
  home: new Home(),
));


class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
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
              new Tab(icon: Icon(Icons.timer)),
              new Tab(text: "Verbindung"),
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
  FlutterBlueApp blue = new FlutterBlueApp();
  Widget build(BuildContext context) {
    return new TabBarView(
      children: <Widget>[
        new CalculationWindow(blue: blue,),
        new IndividualWindow(blue: blue),
        blue,
      ],
    );
  }
}

