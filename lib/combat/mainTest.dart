import 'package:first_flutter_app/combat/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';

import 'ProgressRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  void _openPage(BuildContext context, PageInfo page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (!page.withScaffold) {
        return page.builder(context);
      }

      return PageScaffold(
        title: page.title,
        body: page.builder(context),
        padding: page.padding,
      );
    }));
  }

  List<Widget> _generateItem(BuildContext context, List<PageInfo> children) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () => _openPage(context, page),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter实战"),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text('基础组件'),
            children: _generateItem(context, [
              PageInfo("进度条", (ctx) => ProgressRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text('布局类组件'),
            children: _generateItem(context, [
              PageInfo("Column居中", (ctx) => ProgressRoute()),
            ]),
          ),
        ],
      ),
    );
  }
}
