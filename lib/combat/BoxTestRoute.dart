import 'package:flutter/material.dart';

/// 尺寸显示类容器
class BoxTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 50, // 最小高度为50px
            minWidth: double.infinity, // 宽度尽可能的大
          ),
          child: Container(
            height: 5,
            child: redBox,
          ),
        ),
        SizedBox(
          width: 60,
          height: 60,
          child: redBox,
        ),
        // 多重限制
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 90, minHeight: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60, minHeight: 60),
            child: redBox,
          ),
        ),
        // UnconstrainedBox 去除多重限制
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 60, minHeight: 100), // 父
          child: UnconstrainedBox(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90, minHeight: 20),
              child: redBox,
            ),
          ),
        ),
      ],
    );
  }

  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );
}
