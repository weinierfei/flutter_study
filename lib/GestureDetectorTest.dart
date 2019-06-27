import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('GestureDetector示例'),
        ),
        body: Center(
          child: GestureDetector(
            child: Text('手势识别'),
            onTap: () {
              print("点击");
            },
            onDoubleTap: () {
              print("双击");
            },
            onLongPress: () {
              print("长按");
            },
            onHorizontalDragStart: (DragStartDetails details) {
              print("水平拖动-->$details");
            },
          ),
        ),
      ),
    );
  }
}
