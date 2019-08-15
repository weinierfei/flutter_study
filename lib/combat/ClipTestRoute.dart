import 'package:flutter/material.dart';

/// 裁剪
class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset('images/avatar.png', width: 60);
    return Center(
      child: Column(
        children: <Widget>[
          avatar, // 不裁剪
          ClipOval(
            child: avatar,
          ), // 裁为圆形
          ClipRRect(
            child: avatar,
            borderRadius: BorderRadius.circular(5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: 0.5, // 宽度设为原来宽度一半, 另一半会溢出
                child: avatar,
              ),
              Text(
                '你好世界',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRect(
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5,
                  child: avatar,
                ),
              ),
              Text(
                '你好世界',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: ClipRect(
              clipper: MyClipper(),
              child: avatar,
            ),
          ),
        ],
      ),
    );
  }
}

/// 自定义裁剪区域
class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(10, 15, 40, 30);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
