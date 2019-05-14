import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// => Dart 中单行函数或方法的简写
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final wordPair = WordPair.random();
    return MaterialApp(
//      title: 'Welcome to Fullter',
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Welcome to Fullter'),
//        ),
//        body: Center(
////          child: Text(wordPair.asPascalCase),
//          child: RandomWords(),
//        ), //Center 组件树可以将其子widget树对齐到屏幕中心
//      ), // Scaffold 用于提供默认的导航栏 标题 及包含主屏幕widget树的body属性
//      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  // 在dart中使用下划线前缀标识符,会强制将其变为私有
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Startup Name Generator'),),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

// 用于创建State类
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() {
    return RandomWordsState();
  }
}
