import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('CustomScrollView'),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(// SliverAppBar 作为头部控件
//              title: Text('CustomScrollView Demo'),
              floating: true, // 悬浮样式
              flexibleSpace: Image.network(// 悬浮头部图
                "https://x0.ifengimg.com/ucms/2019_30/FDD671A9E7E49052A594A8EC7D29B3578EA8121A_w632_h637.jpg",
                fit: BoxFit.fill,
              ),
              expandedHeight: 200, // 悬浮控件高度
            ),
            SliverList(// 列表控件
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(// 创建列表
                  title: Text('Item $index'),
                ),
                childCount: 100, // 列表元素个数
              ),
            ),
          ],
        ),
      ),
    );
  }
}
