import 'package:flutter/material.dart';

/// Theme
class ThemeTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThemeTestRouteState();
  }
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  Color _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor, // 用于导航栏 FloatingActionButton的背景色
        iconTheme: IconThemeData(color: _themeColor), // 用于Icon颜色
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('主题测试'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text('  颜色跟随主题'),
              ],
            ),
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(
                  color: Colors.black,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text('  颜色固定黑色'),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _themeColor =
                  _themeColor == Colors.teal ? Colors.blue : Colors.teal;
            });
          },
          child: Icon(Icons.palette),
        ),
      ),
    );
  }
}

/// 颜色
class ColorTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NavBar(
          color: Colors.blue,
          title: '标题',
        ),
        NavBar(
          color: Colors.white,
          title: '标题',
        ),
      ],
    );
  }
}

class NavBar extends StatelessWidget {
  final String title;
  final Color color;

  NavBar({
    Key key,
    this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
