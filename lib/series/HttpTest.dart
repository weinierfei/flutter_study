import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  List data;

  @override
  void initState() {
    super.initState();
    // 获取数据
    _pullNet();
  }

  void _pullNet() async {
    await http
        .get("http://www.wanandroid.com/project/list/1/json?cid=1")
        .then((http.Response response) {
      var convertDataToJson = json.decode(response.body);
      convertDataToJson = convertDataToJson["data"]["datas"];
      print(convertDataToJson);
      setState(() {
        data = convertDataToJson;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: data != null ? _getItem() : _loading(),
      ),
    );
  }

  List<Widget> _getItem() {
    return data.map((item) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _getRowWidget(item),
        ),
        elevation: 3.0,
        margin: const EdgeInsets.all(10.0),
      );
    }).toList();
  }

  Widget _getItem2() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _getRowWidget2(),
      ),
      elevation: 3.0,
      margin: const EdgeInsets.all(10.0),
    );
  }

  Widget _getRowWidget(item) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.tight, // 权重
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '${item['title']}'.trim(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    '${item['desc']}',
                    maxLines: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
        ClipRect(
          child: FadeInImage.assetNetwork(
            placeholder: "images/1.png",
            image: "${item['envelopePic']}",
            width: 50.0,
            height: 50.0,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }

  Widget _getRowWidget2() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.tight, // 权重
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'title'.trim(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    'desc',
                    maxLines: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
        ClipRect(
          child: FadeInImage.assetNetwork(
            placeholder: "images/1.png",
            image: "images/2.png",
            width: 50.0,
            height: 50.0,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }

  List<Widget> _loading() {
    return <Widget>[
      Container(
        height: 300.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 1.0,
              ),
              Text("正在加载"),
            ],
          ),
        ),
      ),
    ];
  }
}
