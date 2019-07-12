import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Container测试"),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            // 边框
            border: Border.all(
              color: Colors.red,
            ),
            image: DecorationImage(
              image: NetworkImage(
                  'https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png'),
              fit: BoxFit.contain,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3.0),
              topRight: Radius.circular(6.0),
              bottomLeft: Radius.circular(9.0),
              bottomRight: Radius.circular(0.0),
            ),
          ),
          child: Text(''),
        ),
      ),
    );
  }
}
