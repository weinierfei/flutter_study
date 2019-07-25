import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  TextStyle redStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red);
  TextStyle blackStyle = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('经典控件'),
        ),
        body: Column(
          children: <Widget>[
            Text.rich(
              TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '文本是视图系统中的常见控件，用来显示一段特定样式的字符串，类似', style: redStyle),
                TextSpan(text: 'Android', style: blackStyle),
                TextSpan(text: '中的', style: redStyle),
                TextSpan(text: 'TextView', style: blackStyle),
              ]),
              textAlign: TextAlign.center,
            ),
            FlatButton(
              color: Colors.yellow,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              colorBrightness: Brightness.light,
              // 确保文字按钮为深色
              onPressed: () => print("----"),
              child: Row(
                children: <Widget>[
                  Icon(Icons.add),
                  Text("Add"),
                ],
              ),
            ),
            CachedNetworkImage(
              imageUrl:
                  'https://x0.ifengimg.com/ucms/2019_30/B9F19EDD5A0D56BF0C094BAB2D788D55E256C959_w690_h1008.jpg',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }
}
