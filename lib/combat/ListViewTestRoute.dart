import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/// ListView
class ListViewTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListViewTestRoute();
  }
}

class _ListViewTestRoute extends State<ListViewTestRoute> {
  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('商品列表'),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: _words.length,
            separatorBuilder: (context, index) => Divider(
              height: 0,
            ),
            itemBuilder: (context, index) {
              if (_words[index] == loadingTag) {
                // 到了末尾
                if (_words.length - 1 < 100) {
                  // 获取数据
                  _retrieveData();
                  // 加载等待loading
                  return Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "没有更多了",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
              }
              return ListTile(
                title: Text(_words[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  void _retrieveData() {
    var list = generateWordPairs().take(20).map((e) => e.asPascalCase).toList();
    Future.delayed(Duration(seconds: 2)).then((e) {
      setState(() {
        _words.insertAll(_words.length - 1, list);
        print('---------->$_words');
      });
    });
  }
}
