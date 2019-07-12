import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('stack测试'),
        ),
        body: isVisible
            ? Container(
                color: Colors.yellow,
                height: 150.0,
                width: 500.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 40),
                      color: Colors.blueAccent,
                      height: 50.0,
                      width: 100.0,
                      alignment: Alignment.center,
                      child: Text("un-Positioned"),
                    ),
                    Positioned(
                      left: 40.0,
                      top: 30.0,
                      child: Container(
                        color: Colors.pink,
                        height: 50.0,
                        width: 95.0,
                        alignment: Alignment.center,
                        child: Text('Positioned'),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
