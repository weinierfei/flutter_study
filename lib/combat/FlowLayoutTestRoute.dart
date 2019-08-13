import 'package:flutter/material.dart';

/// 流式布局
class FlowLayoutTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
          spacing: 8, // 主轴方向(水平)
          runSpacing: 4,
          alignment: WrapAlignment.center, // 沿主轴方向居中
          children: <Widget>[
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('A'),
              ),
              label: Text('Hamilton'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('M'),
              ),
              label: Text('Lafayette'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('H'),
              ),
              label: Text('Mulligan'),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text('J'),
              ),
              label: Text('Laurens'),
            ),
          ],
        ),
        //Flow
        Flow(
          delegate: TestFlowDelegate(EdgeInsets.all(10)),
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              color: Colors.red,
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.green,
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.blue,
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.yellow,
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.brown,
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.purple,
            ),
          ],
        ),
      ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate(this.margin);

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(double.infinity, 200);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
