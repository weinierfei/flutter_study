import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('登录表单'),
        ),
        body: FormTestRoute(),
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

  bool isNode1HasFocus = false;

  @override
  void initState() {
    super.initState();

    focusNode1.addListener(() {
      setState(() {
        focusNode1.hasFocus ? isNode1HasFocus = true : isNode1HasFocus = false;
      });
    });
  }

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
                  color: isNode1HasFocus ? Colors.red : Colors.grey[200],
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

/// Form 表单
class FormTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormTestRouteState();
  }
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _unameController,
              decoration: InputDecoration(
                labelText: '用户名',
                hintText: '请输入用户名',
                icon: Icon(Icons.person),
              ),
              validator: (v) {
                return v.trim().length > 0 ? null : "用户名不能为空";
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                labelText: '密 码',
                hintText: '请输入密码',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (v) {
                return v.trim().length > 5 ? null : '密码不能少于6位';
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 28),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.all(15),
                      child: Text('登录'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        // 在这里不能通过FormState.of(context) 方法获取,因为此处的context为FormTestRoute的context
                        if ((_formKey.currentState as FormState).validate()) {
                          // 验证通过 ,提交数据
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
