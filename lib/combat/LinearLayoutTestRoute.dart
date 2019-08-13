import 'package:flutter/material.dart';

/// 线性布局
class LinearLayoutTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // 测试row对齐方式 排除Column默认居中对齐的干扰
          children: <Widget>[
            Text('hello world'),
            Text('I am Jack'),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hello world'),
            Text('I am Jack'),
          ],
        ),
        Row(
          textDirection: TextDirection.rtl, // 组件从右往左排列
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('hello world'),
            Text('I am Jack'),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up, // up 从低向高 down 从高向低
          children: <Widget>[
            Text(
              'hello world',
              style: TextStyle(fontSize: 30.0),
            ),
            Text('I am Jack'),
          ],
        ),
      ],
    );
  }
}
