import 'package:flutter/material.dart';

class NotificationTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationTestRouteState();
  }
}

class _NotificationTestRouteState extends State<NotificationTestRoute> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        print('结果: ${notification.msg}');
        return false;
      },
      child: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg + "   ";
          });
          return false; // 此处为true 则 终止通知
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Builder(
                builder: (context) {
                  return RaisedButton(
                    child: Text('发送通知'),
                    onPressed: () => MyNotification("你好 ").dispatch(context),
                  );
                },
              ),
              Text(_msg),
            ],
          ),
        ),
      ),
    );
  }
}

/// 自定义通知类
class MyNotification extends Notification {
  final String msg;

  MyNotification(this.msg);
}
