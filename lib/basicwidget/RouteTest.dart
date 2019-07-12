import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'route test',
      home: FirstPage(),
      routes: <String, WidgetBuilder>{
        '/first': (BuildContext context) => FirstPage(),
        '/second': (BuildContext context) => SecondPage(),
      },
      initialRoute: '/first',
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一页'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: RaisedButton(
            child: Text("跳转到第二页"),
            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => SecondPage()));
              Navigator.pushNamed(context, '/second');
            }),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第二页"),
      ),
      body: RaisedButton(
          child: Text("回到上一页"),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
