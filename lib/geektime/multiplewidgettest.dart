import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('多widget测试'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                color: Colors.yellow,
                width: 60,
                height: 80,
              ),
            ),
            Container(
              color: Colors.red,
              width: 100,
              height: 180,
            ),
            Container(
              color: Colors.black,
              width: 60,
              height: 80,
            ),
            Expanded(
              flex: 0,
              child: Container(
                color: Colors.green,
                width: 60,
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
