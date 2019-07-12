import 'package:flutter/material.dart';

void main() => runApp(MyAppBuilder(
      items: new List<String>.generate(300, (i) => "第$i行"),
    ));

/// ListView.separated创建
class MyAppSeparated extends StatelessWidget {
  final List<String> items;

  MyAppSeparated({@required this.items});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fltter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView.separated示例'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                leading: Icon(Icons.access_time),
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                constraints: BoxConstraints.tightFor(height: 0.2),
                color: Colors.black45,
              );
            },
            itemCount: items.length),
      ),
    );
  }
}

///  ListView.builder创建
class MyAppBuilder extends StatelessWidget {
  final List<String> items;

  MyAppBuilder({@required this.items});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView.builder示例'),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(items[index]),
              onDismissed: (direction) {
                items.removeAt(index);
              },
              child: ListTile(
                leading: Icon(Icons.access_time),
                title: Text(items[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// ListView默认构造函数
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView示例'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('第一行'),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('第二行'),
            ),
          ],
        ),
      ),
    );
  }
}
