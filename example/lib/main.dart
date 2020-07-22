import 'package:flutter/material.dart';
import 'package:cupertino_timer/cupertino_timer.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer Demo',
      home: TimerHomePage(title: 'Timer Demo Page'),
    );
  }
}

class TimerHomePage extends StatefulWidget {
  TimerHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TimerHomePageState createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              child: CupertinoTimer(
                duration: Duration(minutes: 5),
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: CupertinoTimer(
                duration: Duration(minutes: 5),
                startOnInit: true,
                timeStyle: TextStyle(fontFamily: 'Avenir'),
                ringColor: Colors.blue,
                ringStroke: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
