import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: FocusTestRoute(),
      ),
    );
  }
}

/// 用户登录
class LoginTest extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          autofocus: true,
          controller: _nameController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: '用户名',
            hintText: '请输入手机号或邮箱',
            prefixIcon: Icon(Icons.person),
          ),
          onChanged: (string) {
            print("手机号为: $string");
          },
        ),
        TextField(
          obscureText: true, //隐藏正在编辑的文本
          decoration: InputDecoration(
            labelText: '密 码',
            hintText: '请输入密码',
            prefixIcon: Icon(Icons.lock),
          ),
          onChanged: (string) {
            print("密码为: $string");
          },
        ),
      ],
    );
  }
}

/// 焦点控制
class FocusTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FocusTestRouteState();
  }
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            child: TextField(
              autofocus: true,
              focusNode: focusNode1,
              decoration: InputDecoration(
                labelText: "input1",
                border: InputBorder.none,
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[200],
                  width: 1,
                ),
              ),
            ),
          ),
          TextField(
            focusNode: focusNode2,
            decoration: InputDecoration(
              labelText: "input2",
            ),
          ),
          Builder(builder: (ctx) {
            return Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('移动焦点'),
                  onPressed: () {
                    if (null == focusScopeNode) {
                      focusScopeNode = FocusScope.of(context);
                    }
                    focusScopeNode.requestFocus(focusNode2);

                    focusNode1.addListener(() {
                      print("1是否有焦点--> ${focusNode1.hasFocus}");
                      print("2是否有焦点--> ${focusNode2.hasFocus}");
                    });
                  },
                ),
                RaisedButton(
                  child: Text('隐藏键盘'),
                  onPressed: () {
                    // 当所有编辑框都失去焦点时键盘收起
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
