import 'package:first_flutter_app/combat/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';

import 'AlignTestRoute.dart';
import 'BoxTestRoute.dart';
import 'DecorationTestRoute.dart';
import 'FlexLayoutTestRoute.dart';
import 'FlowLayoutTestRoute.dart';
import 'LinearLayoutTestRoute.dart';
import 'PaddingTestRoute.dart';
import 'ProgressRoute.dart';
import 'StackLayoutTestRoute.dart';
import 'TransformTestRoute.dart';

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
              PageInfo("线性布局", (ctx) => LinearLayoutTest()),
              PageInfo("弹性布局", (ctx) => FlexLayoutTestRoute()),
              PageInfo("流式布局", (ctx) => FlowLayoutTestRoute()),
              PageInfo("层叠布局", (ctx) => StackLayoutTestRoute()),
              PageInfo("对齐与相对定位", (ctx) => AlignTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text('容器类组件'),
            children: _generateItem(context, [
              PageInfo("填充(Padding)", (ctx) => PaddingTestRoute()),
              PageInfo("尺寸限制类容器", (ctx) => BoxTestRoute()),
              PageInfo("装饰类容器", (ctx) => DecorationTestRoute()),
              PageInfo("变换(Transform)", (ctx) => TransformTestRoute()),
            ]),
          ),
        ],
      ),
    );
  }
}
