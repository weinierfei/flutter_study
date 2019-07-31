import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// 1. Scaffold 属于Material组件,实现了MD的基本布局结构,因此经常作为MaterialApp的子Widget
/// 2. Scaffold 会自动填充可用的空间 (占据整个窗口或者屏幕)
/// 3. Scaffold 会自动适配屏幕
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scaffold 示范演示'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.share), onPressed: () => print("添加按钮"))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Text('Scaffold'),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 100,
          ),
        ),
        drawer: Drawer(
          child: Center(
            child: Text('抽屉'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => print(''),
        ),
      ),
    );
  }
}
