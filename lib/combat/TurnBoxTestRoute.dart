import 'package:flutter/material.dart';

class TurnBoxTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TurnBoxTestRouteState();
  }
}

class _TurnBoxTestRouteState extends State<TurnBoxTestRoute> {
  double _turns = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TurnBox(
            turns: _turns,
            speed: 500,
            child: Icon(
              Icons.refresh,
              size: 50,
            ),
          ),
          TurnBox(
            turns: _turns,
            speed: 1000,
            child: Icon(
              Icons.refresh,
              size: 150,
            ),
          ),
          RaisedButton(
            child: Text('顺时针旋转1/5圈'),
            onPressed: () {
              setState(() {
                _turns += 0.2;
              });
            },
          ),
          RaisedButton(
            child: Text('逆时针旋转1/5圈'),
            onPressed: () {
              setState(() {
                _turns -= 0.2;
              });
            },
          ),
        ],
      ),
    );
  }
}

/// 以任意角度来旋转子节点的组件 同时带有过度动画
class TurnBox extends StatefulWidget {
  final double turns;
  final int speed;
  final Widget child;

  TurnBox({
    Key key,
    this.turns,
    this.speed,
    this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TurnBoxState();
  }
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity,
    );

    _controller.value = widget.turns;
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(
          milliseconds: widget.speed ?? 200,
        ),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
