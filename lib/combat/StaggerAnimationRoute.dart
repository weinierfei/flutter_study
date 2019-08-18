import 'package:flutter/material.dart';

class StaggerAnimationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggerAnimationRouteState();
  }
}

/// 交织动画
class _StaggerAnimationRouteState extends State<StaggerAnimationRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
  }

  Future<Null> _playAnimation() async {
    try {
      // 先正向执行动画
      await _controller.forward().orCancel;
      // 再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _playAnimation();
      },
      child: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          child: StaggerAnimation(
            controller: _controller,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class StaggerAnimation extends StatelessWidget {
  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    height = Tween<double>(
      begin: 0.0,
      end: 300.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.6,
        curve: Curves.ease,
      ),
    ));

    color = ColorTween(begin: Colors.green, end: Colors.red)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.6,
        curve: Curves.ease,
      ),
    ));

    padding = Tween<EdgeInsets>(
            begin: EdgeInsets.only(
              left: 0.0,
            ),
            end: EdgeInsets.only(left: 1000))
        .animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.6,
        1.0,
        curve: Curves.ease,
      ),
    ));
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
