import 'package:flutter/material.dart';

class AnimatedSwitcherRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimatedSwitcherRouteState3();
  }
}

/// 通用动画 (在切换新旧UI元素的场景中十分实用)
class _AnimatedSwitcherRouteState extends State<AnimatedSwitcherRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 1));
              return ScaleTransition(
                child: child,
                scale: animation,
              );
            },
            child: Text(
              '$count',
              key: ValueKey<int>(count),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          RaisedButton(
            child: Text('+1'),
            onPressed: () {
              setState(() {
                count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

/// 由右向左 (左出右入)
class _AnimatedSwitcherRouteState2 extends State<AnimatedSwitcherRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
              return MySlideTransition(
                child: child,
                position: tween.animate(animation),
              );
            },
            child: Text(
              '$count',
              key: ValueKey<int>(count),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          RaisedButton(
            child: Text('+1'),
            onPressed: () {
              setState(() {
                count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

///  左入右出
class _AnimatedSwitcherRouteState3 extends State<AnimatedSwitcherRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransitionX(
                child: child,
                position: animation,
                direction: AxisDirection.down,
              );
            },
            child: Text(
              '$count',
              key: ValueKey<int>(count),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          RaisedButton(
            child: Text('+1'),
            onPressed: () {
              setState(() {
                count += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

/// 可定义方向的入场
class SlideTransitionX extends AnimatedWidget {
  Animation<double> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  // 退场方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.child,
    this.direction = AxisDirection.down,
  })  : assert(position != null),
        super(
          key: key,
          listenable: position,
        ) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

/// 自定义AnimatedWidget (左出右入)
class MySlideTransition extends AnimatedWidget {
  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  MySlideTransition(
      {Key key,
      @required Animation<Offset> position,
      this.transformHitTests = true,
      this.child})
      : assert(position != null),
        super(
          key: key,
          listenable: position,
        );

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
