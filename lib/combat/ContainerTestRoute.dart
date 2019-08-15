import 'package:flutter/material.dart';

class ContainerTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, left: 100),
          constraints: BoxConstraints.tightFor(width: 200, height: 150),// 卡片大小
          decoration: BoxDecoration(// 背景装饰
            gradient: RadialGradient( // 渐变色
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: 0.98, // 渐变半径
            ),
            boxShadow: [ // 卡片阴影
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4,
              ),
            ],
          ),
          transform: Matrix4.rotationZ(0.2),// 卡片倾斜
          alignment: Alignment.center, // 卡片内子控件居中
          child: Text(
            '5.20',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        ),

        // Container中Padding和margin的区别  : margin的留白在控件外 Padding的留白在控件内
        Container(
          margin: EdgeInsets.all(80),
          color: Colors.orange,
          child: Text('Hello world'),
        ),
        Container(
          padding: EdgeInsets.all(80),
          color: Colors.orange,
          child: Text('Hello world'),
        ),
      ],
    );
  }
}
