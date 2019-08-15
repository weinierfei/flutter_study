import 'package:flutter/material.dart';

/// 异步UI更新
class FutureAndStreamTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: getStreamBuilder(),
    );
  }
}

/// FutureBuilder
Widget getFutureBuilder() {
  return FutureBuilder<String>(
    future: mockNetWorkData(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Text(
            'Error :${snapshot.error}',
            style: TextStyle(color: Colors.red),
          );
        } else {
          return Text('data: ${snapshot.data}');
        }
      } else {
        // 请求中 显示loading
        return CircularProgressIndicator();
      }
    },
  );
}

Future<String> mockNetWorkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是网络数据");
}

///-----------StreamBuilder-------------
Widget getStreamBuilder() {
  return StreamBuilder(
    stream: counter(),
    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
      if (snapshot.hasError) {
        return Text(
          'Error :${snapshot.error}',
          style: TextStyle(color: Colors.red),
        );
      }

      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return Text('没有Stream');
        case ConnectionState.waiting:
          return Text('等待数据...');
        case ConnectionState.active:
          return Text('active :${snapshot.data}');
        case ConnectionState.done:
          return Text('Stream已关闭');
      }
      return null;
    },
  );
}

///每间隔1s生成一个数字
Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}
