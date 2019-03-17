import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vibration/vibration.dart';
import 'package:day_time_app/Setting/connection.dart';

class Timer extends StatefulWidget {
  Duration duration;
  FlutterBlueApp blue;

  Timer(Duration duration, FlutterBlueApp blue) {
    this.duration = duration;
    this.blue = blue;
  }

  @override
  _timerState createState() => _timerState(duration, blue);
}

class _timerState extends State<Timer> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController controller;
  Duration duration;
  FlutterBlueApp blue;

  _timerState(Duration duration, FlutterBlueApp blue) {
    this.duration = duration;
    this.blue = blue;
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inMilliseconds == 0) {
      try {
        blue.vibrateON();
      } catch (e) {

      }
      Vibration.vibrate(
          pattern: [0, 500, 300, 200, 200, 200, 200, 200, 100, 500]
      );
      return 'Eincremen';
    }
    return '${(duration.inHours).toString().padLeft(2, '0')}:'
        '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:'
        '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    controller.reverse(from: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column (
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center ,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack (
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                            animation: controller,
                            builder: (BuildContext context, Widget child) {
                              return new CustomPaint(
                                painter: TimerPainter(
                                  animation: controller,
                                  backgroundColor: Colors.white,
                                  color: Colors.red,
                                ),
                              );
                            }
                        ),
                      ),
                      Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "",
                                style: TextStyle(fontSize: 65),
                              ),
                              AnimatedBuilder (
                                  animation: controller,
                                  builder: (BuildContext context, Widget child) {
                                    return new Text(
                                        timerString,
                                        style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.red,
                                        )
                                    );
                                  }
                              )
                            ],
                          )
                      ),
                    ]
                  )
                )
              )
            ),
            Container (
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    child: AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(Icons.arrow_back);
                        }
                    ),
                    onPressed: () {
                      try {
                        blue.vibrateOFF();
                      } catch(e) {
                      }
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
        ..color = backgroundColor
        ..strokeWidth = 5.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}