import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('PageView示例'),
        ),
        body: PageView(
          onPageChanged: (index) {
            print('当前为第$index 页');
          },
          children: <Widget>[
            ListTile(
              title: Text("第0页"),
            ),
            ListTile(
              title: Text("第1页"),
            ),
            ListTile(
              title: Text("第2页"),
            ),
          ],
        ),
      ),
    );
  }
}
