import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Paint'),
        ),
        body: Center(
          child: Container(
            child: DemoWidget(),
            width: 200.0,
            height: 200.0,
            color: Colors.deepOrange,
            padding: EdgeInsets.all(30.0),
          ),
        ),
      ),
    );
  }
}

class DemoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemoWidgetState();
  }
}

class _DemoWidgetState extends State<DemoWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: DemoPainter(
            Tween(begin: math.pi * 1.5, end: math.pi * 3.5)
                .chain(CurveTween(curve: Interval(0.5, 1.0)))
                .evaluate(_controller),
            math.sin(Tween(begin: 0.0, end: math.pi).evaluate(_controller)) *
                math.pi,
          ),
        );
      },
    );
  }
}

class DemoPainter extends CustomPainter {
  final double _arrStart;
  final double _arcSweep;

  DemoPainter(this._arrStart, this._arcSweep);

  /// 该方法决定 画什么
  @override
  void paint(Canvas canvas, Size size) {
    double side = math.min(size.width, size.height);
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
        Offset.zero & Size(side, side), _arrStart, _arcSweep, false, paint);
  }

  /// 该方法决定 什么时候开始重绘
  @override
  bool shouldRepaint(DemoPainter other) {
    return _arrStart != other._arrStart || _arcSweep != other._arcSweep;
  }
}
