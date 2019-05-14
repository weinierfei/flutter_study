import 'package:flutter/material.dart';

// => Dart 中单行函数或方法的简写
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Fullter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Fullter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ), //Center 组件树可以将其子widget树对齐到屏幕中心
      ), // Scaffold 用于提供默认的导航栏 标题 及包含主屏幕widget树的body属性
    );
  }
}
