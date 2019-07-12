import 'package:flutter/material.dart';

/// 用于不同数据之间装换的编码器和解码器
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(AssetsWidget());

class AssetsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter",
      home: Scaffold(
        appBar: AppBar(
          title: Text("资源"),
        ),
        body: JsonWidget(),
      ),
    );
  }
}

class JsonWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JsonWidgetState();
  }
}

class _JsonWidgetState extends State<JsonWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // 异步模型:可得到当前widget的状态
//      future: DefaultAssetBundle.of(context).loadString("assets/swordsmen.json"),
      future: rootBundle.loadString("assets/swordsmen.json"),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<dynamic> data = json.decode(snapshot.data.toString());
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text("名字: ${data[index]["name"]}"),
                    Text("绝学: ${data[index]["gongfu"]}"),
                    Image.asset(
                      'images/1.png',
                      height: 100.0,
                    ),
                    Image.asset(
                      'images/2.png',
                      height: 100.0,
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
