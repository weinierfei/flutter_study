import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: Text("文本输入框"),
        ),
        body: MessageForm(),
      ),
    );
  }
}

class MessageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessageFormState();
  }
}

class _MessageFormState extends State<MessageForm> {
  var editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // 占满一行中除了RaisedButton外的所有空间
        Expanded(
          child: TextField(
            controller: editController,
          ),
        ),
        RaisedButton(
            child: Text("click"),
            onPressed: () {
              print("输入的内容为: ${editController.text}");
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Center(
                        child: Text("输入的内容为:"),
                      ),
                      content: Text(editController.text),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  });
            }),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    // 释放资源
    editController.dispose();
  }
}
