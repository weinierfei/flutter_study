import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class GestureDetectorTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GestureConflictTestRouteState();
  }
}

/// 点击 双击 长按
class _GestureDetectorTestRouteState extends State<GestureDetectorTestRoute> {
  String _operation = "No Gesture detected!"; // 保用事件名称
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200,
          height: 100,
          child: Text(
            _operation,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        onTap: () => updateText('Tap'), // 点击
        onDoubleTap: () => updateText('DoubleTap'), //双击
        onLongPress: () => updateText('LongPress'), //长按
      ),
    );
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

/// 拖动 滑动
class _DragState extends State<GestureDetectorTestRoute> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text('A'),
            ),
            // 手指按下时触发此回调
            onPanDown: (DragDownDetails e) {
              print("用户手指按下: ${e.globalPosition}");
            },
            // 手指滑动时触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            // 滑动结束时触发词汇的
            onPanEnd: (DragEndDetails e) {
              print(e.velocity);
            },
          ),
        ),
      ],
    );
  }
}

/// 单一方向拖动
class _DragVerticalState extends State<GestureDetectorTestRoute> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text('A'),
            ),
            onVerticalDragUpdate: (DragUpdateDetails e) {
              setState(() {
                _top += e.delta.dy;
              });
            },
          ),
        ),
      ],
    );
  }
}

/// 缩放
class _ScaleTestRouteState extends State<GestureDetectorTestRoute> {
  double _width = 200.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Image.asset(
          "images/1.png",
          width: _width,
        ),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            // 缩放倍数在0.8-10倍之间
            _width = 200 * details.scale.clamp(0.8, 10);
          });
        },
      ),
    );
  }
}

/// GestureRecognizer
class _GestureRecognizerTestRouteState extends State<GestureDetectorTestRoute> {
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false; // 变色开关
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '你好世界'),
            TextSpan(
                text: '点我变色',
                style: TextStyle(
                  color: _toggle ? Colors.blue : Colors.red,
                  fontSize: 30,
                ),
                recognizer: _tapGestureRecognizer
                  ..onTap = () {
                    setState(() {
                      _toggle = !_toggle;
                    });
                  }),
            TextSpan(text: '的开导开导'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }
}

/// 手势竞争
class BothDirectionTestRouteState extends State<GestureDetectorTestRoute> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text('A'),
            ),
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _top += details.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
          ),
        ),
      ],
    );
  }
}

/// 手势冲突 (Listener配合GestureDetector可以解决冲突 ¬)
class _GestureConflictTestRouteState extends State<GestureDetectorTestRoute> {
  double _left = 0.0;
  double _leftB = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text('A'),
            ),
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                _left += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details) {
              print('onHorizontalDragEnd');
            },
            onTapDown: (details) {
              print('onTapDown');
            },
            onTapUp: (details) {
              print('onTapUp');
            },
          ),
        ),

        // 使用Listener监听
        Positioned(
          top: 100,
          left: _leftB,
          child: Listener(
            child: GestureDetector(
              child: CircleAvatar(
                child: Text('B'),
              ),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _leftB += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                print('onHorizontalDragEnd');
              },
            ),
            onPointerDown: (details) {
              print('Down');
            },
            onPointerUp: (details) {
              print('Up');
            },
          ),
        ),
      ],
    );
  }
}
