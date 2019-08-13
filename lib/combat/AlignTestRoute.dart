import 'package:flutter/material.dart';

class AlignTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      color: Colors.blue[50],
      child: Align(
//        alignment: Alignment.topRight,// Alignment可以通过其坐标转换公式将其坐标转为子元素的具体偏移坐标
        // (Alignment.x*childWidth/2+childWidth/2, Alignment.x*childHeight+childHeight/2)   childWidth子元素宽
        alignment: FractionalOffset(0.5, 0.6),//FractionalOffset 的坐标原点为矩形的左侧顶点  实际偏移 = (FractionalOffset.x * childWidth, FractionalOffset.y * childHeight)
        child: FlutterLogo(
          size: 60,
        ),
      ),
    );
  }
}
