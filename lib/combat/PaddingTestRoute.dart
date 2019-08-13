import 'package:flutter/material.dart';

/// 填充
class PaddingTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // 上下左右各添加16像素
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text('Hello world'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('I am Jack'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text('Your friend'),
          ),
        ],
      ),
    );
  }
}
