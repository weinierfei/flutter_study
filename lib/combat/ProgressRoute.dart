import 'package:flutter/material.dart';

class ProgressRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProgressRouteState();
  }
}

class _ProgressRouteState extends State<ProgressRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // 循环的进度条
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          // 停留在进度为50的进度条
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          // 圆形 循环进度条
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            strokeWidth: 2,
          ),
          // 圆形 进度条显示50%
          CircularProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          // 尺寸限制类容器 线性高度为3  LinearProgressIndicator默认为6
          SizedBox(
            height: 3,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
          // 圆形 默认大小36
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
          // 椭圆
          SizedBox(
            height: 100,
            width: 130,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
          // 颜色变化
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                .animate(_animationController),
            value: _animationController.value,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                .animate(_animationController),
            value: _animationController.value,
          ),
        ].map((e) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: e,
          );
        }).toList(),
      ),
    );
  }
}
