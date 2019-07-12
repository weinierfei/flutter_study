import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(FlexWidget());

/// 弹性布局
class FlexWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text("弹性布局"),
        ),
        body: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 60.0,
                width: 30.0,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: 60.0,
                width: 30.0,
                color: Colors.yellow,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 60.0,
                width: 30.0,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 层式布局
class StackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text("层式布局示例"),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              left: 90.0,
              top: 120.0,
              child: Image.asset(
                'images/1.png',
                width: 200.0,
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Text(
                "Android进阶三部曲",
                style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
              ),
              height: 50.0,
              width: 110.0,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// 流式布局
class ChipWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: Text("流式布局"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Wrap(
            direction: Axis.horizontal, // 水平方向
            spacing: 8.0, // 水平方向的间距
            runSpacing: 12.0, // 交叉轴方向的间距 (此处为垂直方向)
            children: <Widget>[
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("1"),
                ),
                label: Text("Android进阶之光"),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("2"),
                ),
                label: Text("Android进阶解密"),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("3"),
                ),
                label: Text("Android进阶?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 线性布局
/// Row: 水平方向线性布局
/// Column :垂直方向线性布局
class RowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: Text('Row示例'),
        ),
        body: Padding(
          padding: EdgeInsets.all(40.0),
          child: Row(
            children: <Widget>[
              Text("Android进阶之光"),
              Text("Android进阶解密"),
            ],
          ),
        ),
      ),
    );
  }
}
