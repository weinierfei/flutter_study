import 'package:flutter/material.dart';

class ScrollControllerTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollNotificationTestRouteState();
  }
}

/// ScrollController
class _ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller;
  bool showToTopBtn = false;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      print(_controller.offset);
      if (_controller.offset < 100 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('滚动控制'),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 100,
          itemExtent: 50,
          controller: _controller,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('$index'),
            );
          },
        ),
      ),
      floatingActionButton: showToTopBtn
          ? FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(
                  0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                );
              },
            )
          : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// NotificationListener
class _ScrollNotificationTestRouteState
    extends State<ScrollControllerTestRoute> {
  String _progress = '0%';

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          // pixels:当前滚动位置
          // maxScrollExtent: 最大可滚动位置
          // extentBefore : 顶部已滑屏幕的程度
          // extentInside : 当前显示在屏幕上的长度
          // extentAfter : 列表底部未显示到屏幕中的部分的长度
          // atEdge : 是否滑动到了可滚动组件的边界
          double progress = notification.metrics.pixels / notification.metrics.maxScrollExtent;
          setState(() {
            _progress = "${(progress * 100).toInt()}%";
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('$index'),
                );
              },
              itemExtent: 50,
              itemCount: 100,
            ),
            CircleAvatar(
              radius: 30,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
