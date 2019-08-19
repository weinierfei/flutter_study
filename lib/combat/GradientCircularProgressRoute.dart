import 'dart:math';

import 'package:first_flutter_app/combat/TurnBoxTestRoute.dart';
import 'package:flutter/material.dart';

/// 圆形背景渐变进度条
class GradientCircularProgressRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GradientCircularProgressRouteState();
  }
}

class _GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: <Widget>[
                      Wrap(
                        spacing: 10,
                        runSpacing: 16,
                        children: <Widget>[
                          GradientCircularProgressPainter(
                            colors: [Colors.blue, Colors.blue],
                            radius: 50,
                            strokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressPainter(
                            colors: [Colors.red, Colors.orange],
                            radius: 50,
                            strokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressPainter(
                            colors: [Colors.teal, Colors.cyan],
                            radius: 50,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            value: CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.decelerate,
                            ).value,
                          ),
                          TurnBox(
                            turns: 1 / 8,
                            child: GradientCircularProgressPainter(
                              colors: [Colors.red, Colors.orange, Colors.red],
                              radius: 50,
                              strokeWidth: 5,
                              strokeCapRound: true,
                              backgroundColor: Colors.red[50],
                              totalAngle: 1.5 * pi,
                              value: CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.easeOut,
                              ).value,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: GradientCircularProgressPainter(
                              colors: [Colors.blue[700], Colors.blue[200]],
                              radius: 50,
                              strokeWidth: 3,
                              strokeCapRound: true,
                              backgroundColor: Colors.transparent,
                              value: _animationController.value,
                            ),
                          ),
                          GradientCircularProgressPainter(
                            colors: [
                              Colors.red,
                              Colors.amber,
                              Colors.cyan,
                              Colors.green[200],
                              Colors.blue,
                              Colors.red
                            ],
                            radius: 50,
                            strokeCapRound: true,
                            strokeWidth: 50,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressPainter(
                            colors: [Colors.blue[700], Colors.blue[200]],
                            radius: 100,
                            strokeWidth: 20.0,
                            value: _animationController.value,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: GradientCircularProgressPainter(
                              colors: [Colors.blue[700], Colors.blue[300]],
                              radius: 100,
                              strokeWidth: 20,
                              value: _animationController.value,
                              strokeCapRound: true,
                            ),
                          ),
                          ClipRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: 0.5,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: SizedBox(
                                  child: TurnBox(
                                    turns: .75,
                                    child: GradientCircularProgressPainter(
                                      colors: [Colors.teal, Colors.cyan[500]],
                                      radius: 100,
                                      strokeWidth: 8,
                                      value: _animationController.value,
                                      totalAngle: pi,
                                      strokeCapRound: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 104,
                            width: 200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Positioned(
                                  height: 200,
                                  top: 0.0,
                                  child: TurnBox(
                                    turns: 0.75,
                                    child: GradientCircularProgressPainter(
                                      colors: [Colors.teal, Colors.cyan[500]],
                                      radius: 100,
                                      strokeWidth: 8,
                                      strokeCapRound: true,
                                      value: _animationController.value,
                                      totalAngle: pi,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "${(_animationController.value * 100).toInt()}%",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.blueGrey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class GradientCircularProgressPainter extends StatelessWidget {
  // 线条宽
  final double strokeWidth;

  // 圆圈的半径
  final double radius;

  // 两端是否为圆角
  final bool strokeCapRound;

  // 当前进度 (0.0-1.0)
  final double value;

  // 进度条背景颜色
  final Color backgroundColor;

  // 渐变色数组
  final List<Color> colors;

  // 进度条的总弧度 (2*pi为整个圆)
  final double totalAngle;

  // 渐变色的终止点
  final List<double> stops;

  GradientCircularProgressPainter({
    this.strokeWidth = 2.0,
    @required this.radius,
    @required this.colors,
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    double _offset = 0.0;
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          strokeWidth: strokeWidth,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          total: totalAngle,
          radius: radius,
          colors: _colors,
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  // 线条宽
  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double> stops;

  _GradientCircularProgressPainter({
    this.strokeWidth: 10.0,
    this.strokeCapRound: false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.radius,
    this.total = 2 * pi,
    @required this.colors,
    this.stops,
    this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }
    double _offset = strokeWidth / 2;
    double _value = (value ?? 0.0);
    _value = _value.clamp(0.0, 1.0) * total;
    double _start = 0.0;

    if (strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;
    // 绘制背景
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }
    // 绘制前景 应用渐变色
    if (_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);
    }
    canvas.drawArc(rect, _start, _value, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
