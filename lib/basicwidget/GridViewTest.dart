import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('GridView示例'),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          children: <Widget>[
            ListTile(
              title: Text("item1"),
            ),
            ListTile(
              title: Text("item2"),
            ),
            ListTile(
              title: Text("item3"),
            ),
            ListTile(
              title: Text("item4"),
            ),
            ListTile(
              title: Text("item5"),
            ),
          ],
        ),
      ),
    );
  }
}
