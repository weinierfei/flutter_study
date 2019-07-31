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
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.yellow,
              width: 300,
              height: 300,
            ),
            Positioned(
              left: 18,
              top: 18,
              child: Container(
                color: Colors.green,
                width: 50,
                height: 50,
              ),
            ),
            Positioned(
              left: 18,
              top: 70,
              child: Text(
                'Stack 提供了层叠布局的容器',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
