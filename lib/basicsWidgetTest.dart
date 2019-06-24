import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Basics Widget'),
        ),
        body: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              Text(
                '文本样式',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.indigo,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.red),
              ),
              Image.network(
                "https://upload-images.jianshu.io/upload_images/1417629-53f7d0902457cbe6.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                width: 260,
                height: 100,
                fit: BoxFit.fill,
              ),
              RaisedButton(
                onPressed: (){
                  print("onPressed");
                },
                color: Colors.lightBlueAccent,
                child: Text(
                  'RaisedNutton',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
