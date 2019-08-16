import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

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
          RaisedButton(
            child: Text('自定义'),
            onPressed: () {
              showCustomDialog<bool>(
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

  // 选择器
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

  Future<T> showCustomDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          final prefix0.Widget pageChild = Builder(builder: builder);
          return SafeArea(
            child: Builder(builder: (BuildContext context) {
              return theme != null
                  ? Theme(
                      data: theme,
                      child: pageChild,
                    )
                  : pageChild;
            }),
          );
        },
        barrierDismissible: barrierDismissible,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black87,
        transitionDuration: Duration(milliseconds: 150),
        transitionBuilder: _buildMaterialDialogTransitions);
  }

  Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // 缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}

class DialogRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DialogRouteState();
  }
}

class _DialogRouteState extends State<DialogRoute> {
  bool withTree = false; // 复选框选中
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('对话框测试'),
          onPressed: () async {
            bool delete = await showDeleteConfirmDialog();
            if (delete == null) {
              print('取消删除');
            } else {
              print('同时删除子目录 $delete');
            }
          },
        ),
        RaisedButton(
          child: Text('显示底部菜单'),
          onPressed: () async {
            int type = await _showModalBottomSheet();
            print('$type');
          },
        ),
        RaisedButton(
          child: Text('等待框'),
          onPressed: () {
            showLoadingDialog2();
          },
        ),
        RaisedButton(
          child: Text('时间选择1'),
          onPressed: () async {
            DateTime dateTime = await _showDatePicker1();
            print("$dateTime");
          },
        ),
      ],
    );
  }

  Future<bool> showDeleteConfirmDialog() {
    withTree = false;
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('确定要删除当前文件吗?'),
                Row(
                  children: <Widget>[
                    Text('同时删除子目录?'),
                    DialogCheckbox(
                      value: withTree,
                      onChanged: (bool value) {
                        withTree = !withTree;
                      },
                    ),
                  ],
                ),
              ],
            ),
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

  // 底部菜单
  Future<int> _showModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('$index'),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
          itemCount: 30,
        );
      },
    );
  }

  // 等待框
  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top: 26),
                child: Text('正在加载,请稍后...'),
              ),
            ],
          ),
        );
      },
    );
  }

  // 自定义大小的等待框
  showLoadingDialog2() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 280,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 26),
                    child: Text('正在加载,请稍后...'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<DateTime> _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(Duration(
        days: 30,
      )),
    );
  }
}

class DialogCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool value;

  DialogCheckbox({Key key, @required this.onChanged, this.value});

  @override
  State<StatefulWidget> createState() {
    return _DialogCheckboxState();
  }
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        widget.onChanged(v);
        setState(() {
          value = v;
        });
      },
    );
  }
}
