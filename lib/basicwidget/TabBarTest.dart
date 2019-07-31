import 'package:flutter/material.dart';

/// 1.TabBar用于显示水平的选项卡，和Android中的TabLayout类似
/// 2.TabBar通常需要配合TabBarView和TabController使用

void main() => runApp(MyApp());

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
    return _MyStatefulWidgetState();
  }
}

/// 自定义TabController
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义TabController"),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(
              text: '热点',
            ),
            Tab(
              text: '体育',
            ),
            Tab(
              text: '科技',
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: Text("热点"),
          ),
          Center(
            child: Text("体育"),
          ),
          Center(
            child: Text("科技"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

/// 使用DefaultTabController
class MyTabController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('DefaultTabController示例'),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              text: '热点',
            ),
            Tab(
              text: '体育',
            ),
            Tab(
              text: '科技',
            ),
          ]),
        ),
        body: TabBarView(children: <Widget>[
          Center(
            child: Text("热点"),
          ),
          Center(
            child: Text("体育"),
          ),
          Center(
            child: Text("科技"),
          ),
        ]),
      ),
    );
  }
}
