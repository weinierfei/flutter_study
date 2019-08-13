import 'package:flutter/material.dart';
import 'dart:math' as math;

/// 变换
class TransformTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.black,
          child: Transform(
            alignment: Alignment.topRight,
            transform: Matrix4.skewY(0.3), // 沿Y轴倾斜0.3弧度
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.deepOrange,
              child: Text('Apartment for rent'),
            ),
          ),
        ),
        // 平移
        Container(
          padding: EdgeInsets.only(top: 20),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.translate(
              offset: Offset(-20, -5),
              child: Text('Hello world'),
            ),
          ),
        ),
        // 旋转
        Container(
          padding: EdgeInsets.only(top: 20),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.rotate(
              angle: math.pi / 2,
              child: Text('Hello world'),
            ),
          ),
        ),
        // 缩放
        Container(
          padding: EdgeInsets.only(top: 20),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.scale(
              scale: 1.5,
              child: Text('Hello world'),
            ),
          ),
        ),

        // RotatedBox应用于layout阶段,会影响子组件的位置和大小
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: RotatedBox(
                  quarterTurns: 1, // 选装90度(1/4圈)
                  child: Text('Hello world'),
                ),
              ),
              Text(
                '你好',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
