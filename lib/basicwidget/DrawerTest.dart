import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// Drawer用法
/// 1. Drawer就是抽屉,可以实现拉出推入效果 类似与Android中的DrawerLayout
/// 2. Drawer通常与Scaffold.drawer属性一起使用
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawerState();
  }
}

class _DrawerState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("drawer示例"),
      ),
      drawer: _drawer,
    );
  }

  get _drawer => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("郭永平"),
              accountEmail: Text("gyp@126.com"),
              currentAccountPicture: CircleAvatar(
                child: Text("X"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.local_post_office),
              title: Text("邮件"),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("设置"),
            ),
          ],
        ),
      );
}
