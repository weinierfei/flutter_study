import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animation demo'),
        ),
        body: AnimationDomeView(),
      ),
    );
  }
}

class AnimationDomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimationState();
  }
}

class _AnimationState extends State<AnimationDomeView>
    with SingleTickerProviderStateMixin {
  static const padding = 16.0;
  AnimationController controller;
  Animation<double> left;
  Animation<Color> color;

  @override
  void initState() {
    super.initState();
    Future(_initState);
  }

  void _initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    final mediaQueryData = MediaQuery.of(context);
    final displayWidth = mediaQueryData.size.width;
    left =
        Tween(begin: padding, end: displayWidth - padding).animate(controller)
          ..addListener(() {
            // 调用setState触发重新build一个widget,在build中根据Animation<T>的当前值看来创建widget,达到动画的效果
            setState(() {});
          })
          // 监听动画状态变化
          ..addStatusListener((status) {
            // 这里让动画往复不断执行

            // 一次动画完成
            if (status == AnimationStatus.completed) {
              controller.reverse();
              // 反着执行的动画结束
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    color = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // 假定一个单位是24
    final unit = 24.0;
    final marginLeft = left == null ? padding : left.value;
    // 把marginLeft单位化
    final unitizedLeft = (marginLeft - padding) / unit;
    final unitizeTop = math.sin(unitizedLeft);
    final marginTop = (unitizeTop + 1) * unit + padding;
    final color = this.color == null ? Colors.red : this.color.value;
    return Container(
      margin: EdgeInsets.only(left: marginLeft, top: marginTop),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(7.5),
        ),
        width: 15.0,
        height: 15.0,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
