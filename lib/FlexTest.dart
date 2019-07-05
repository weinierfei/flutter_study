import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flex测试'),
        ),
        body: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 40.0,
              height: 60.0,
              color: Colors.pink,
              child: Center(
                child: Text('left'),
              ),
            ),
            Container(
              width: 80.0,
              height: 60.0,
              color: Colors.grey,
              child: Center(
                child: Text('moddle'),
              ),
            ),
            Container(
              width: 60.0,
              height: 60.0,
              color: Colors.yellow,
              child: Center(
                child: Text('right'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
