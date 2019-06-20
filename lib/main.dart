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
    theme: new ThemeData(
      primaryColor: Colors.white
    ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  // 在dart中使用下划线前缀标识符,会强制将其变为私有
  final List<WordPair> _suggestions = <WordPair>[];

  // 用于存储用户收藏的单词
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // 使用Scaffold类实现基础的 Material Design 布局
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // 此处每个单词都会调用itemBuilder 偶数行添加单词 奇数行添加分割线
        itemBuilder: (context, i) {
          // 当且仅当此整数为奇数时返回true
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          // 如果是列表的最后一个单词  则接着在生成10个单词
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text("Saved Suggestions"),
            ),
            body: new ListView(
              children: divided,
            ),
          );
        },
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
