import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI basic 1',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Top Lakes"),
        ),
        body: ListView(
          children: <Widget>[
            Image.asset(
              'images/1.png',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
            ),
            _TitleSection(
                'Oeschinen Lake Campground', 'Kandersteg, Switzerland', 41),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButtonColumn(context, Icons.call, "CALL"),
                  _buildButtonColumn(context, Icons.near_me, "ROUTE"),
                  _buildButtonColumn(context, Icons.share, "SHARE"),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                '''
                Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.          
                ''',
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  final String title;
  final String subTitle;
  final int starCount;

  _TitleSection(this.title, this.subTitle, this.starCount);

  @override
  Widget build(BuildContext context) {
    // 为了给title section添加padding,给内容套一个Container
    return Container(
      padding: EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          // expanded 让标题占满屏幕宽度的剩余空间
          Expanded(
            child: Column(
              // Column是竖直方向 cross为交叉,此处为水平方向
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red,
          ),
          Text(starCount.toString()),
        ],
      ),
    );
  }
}

Widget _buildButtonColumn(BuildContext context, IconData icon, String label) {
  final color = Theme.of(context).primaryColor;

  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(
        icon,
        color: color,
      ),
      Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}
