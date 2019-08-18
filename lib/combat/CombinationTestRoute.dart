import 'package:flutter/material.dart';

/// 组合组件
class CombinationTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CombinationTestRouteState();
  }
}

class _CombinationTestRouteState extends State<CombinationTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GradientButton(
            colors: [Colors.orange, Colors.red],
            height: 50,
            child: Text('Submit'),
            onPressed: onTap,
          ),
          GradientButton(
            colors: [Colors.lightGreen, Colors.green[700]],
            height: 50,
            child: Text('Submit'),
            onPressed: onTap,
          ),
          GradientButton(
            colors: [Colors.lightBlue[300], Colors.blueAccent],
            height: 50,
            child: Text('Submit'),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }

  onTap() {
    print("点击事件");
  }
}

class GradientButton extends StatelessWidget {
  // 渐变色数组
  final List<Color> colors;

  // 按钮宽高
  final double width;
  final double height;
  final Widget child;
  final BorderRadius borderRadius;

  // 回调
  final GestureTapCallback onPressed;

  GradientButton({
    this.colors,
    this.width,
    this.height,
    @required this.child,
    this.borderRadius,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //确保colors数组不空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: height,
              width: width,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
