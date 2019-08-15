import 'package:flutter/material.dart';

/// 对话框
class AlertDialogTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('对话框1'),
            onPressed: () {
              showDeleteConfirmDialog1(context);
            },
          ),
          RaisedButton(
            child: Text('对话框2'),
            onPressed: () {
              changeLanguage(context);
            },
          ),
          RaisedButton(
            child: Text('对话框3'),
            onPressed: () {
              showListDialog(context);
            },
          ),
        ],
      ),
    );
  }

// 简单对话框
  Future<bool> showDeleteConfirmDialog1(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('确定要删除当前文件吗?'),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('确定'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        });
  }

  // SimpleDialog
  Future<void> changeLanguage(BuildContext context) async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('简体中文'),
                ),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),
              SimpleDialogOption(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('美式英语'),
                ),
                onPressed: () {
                  Navigator.pop(context, 2);
                },
              ),
            ],
          );
        });

    if (i != null) {
      print('选择了: ${i == 1 ? "简体中文" : "美式英语"}');
    }
  }

  Future<void> showListDialog(BuildContext context) async {
    int index = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          var child = Column(
            children: <Widget>[
              ListTile(
                title: Text('请选择'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('$index'),
                      onTap: () => Navigator.of(context).pop(index),
                    );
                  },
                ),
              ),
            ],
          );
          return Dialog(
            child: child,
          );
        });

    if (index != null) {
      print('点击了: $index');
    }
  }
}
