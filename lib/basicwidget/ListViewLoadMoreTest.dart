import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// 一个带有上拉加载的例子
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  List<int> items = List.generate(20, (i) => i);
  ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false; // 是否正在请求

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });

      List<int> newEntries = await fakeRequest(items.length, items.length + 10);
      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
            _scrollController.offset - (edge - offsetFromBottom),
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }
      }
      setState(() {
        items.addAll(newEntries);
        isPerformingRequest = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite ListView"),
      ),
      body: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return _buildProgressIndicator();
          } else {
            return ListTile(
              title: Text("Number $index"),
            );
          }
        },
        controller: _scrollController,
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

/// from - 包括  to - 不包括
/// 模拟http请求
Future<List<int>> fakeRequest(int from, int to) async {
  return Future.delayed(Duration(seconds: 2), () {
    return List.generate(to - from, (i) => i + from);
  });
}
