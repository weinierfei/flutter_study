import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppWidget(),
    );
  }
}

/// 控制器
class MyAppWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyAppWidget> {
  ScrollController _controller;
  bool isToTop = false; // 标记目前是否需要医用 top 按钮

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > 1000) {
        setState(() {
          isToTop = true;
        });
      } else if (_controller.offset < 300) {
        setState(() {
          isToTop = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('控制器'),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text('Index $index'),
            ),
            itemCount: 100,
            controller: _controller,
          ),
          Container(
            height: 50.0,
            alignment: Alignment.center,
            color: Colors.green,
            child: RaisedButton(
              onPressed: isToTop
                  ? () {
                      if (isToTop) {
                        _controller.animateTo(.0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.ease);
                      }
                    }
                  : null,
              child: Text('Top'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// 带有分割线的列表
class ListViewTest3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView 测试'),
      ),
      body: ListView.separated(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text('title $index'),
          subtitle: Text('body $index'),
        ),
        separatorBuilder: (BuildContext context, int index) => index % 2 == 0
            ? Divider(
                color: Colors.green,
              )
            : Divider(
                color: Colors.red,
              ),
      ),
    );
  }
}

/// 真正需要展示该子 Widget 时再去创建
class ListViewTest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView 测试'),
      ),
      body: ListView.builder(
        itemExtent: 50,
        itemCount: 100,
        itemBuilder: (context, index) => ListTile(
          title: Text('title $index'),
          subtitle: Text('body $index'),
        ),
      ),
    );
  }
}

/// 直接创建子widget
class ListViewTest1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView 测试'),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        itemExtent: 160, // item 延伸尺寸 (宽度)
        children: <Widget>[
          Container(
            color: Colors.black,
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
