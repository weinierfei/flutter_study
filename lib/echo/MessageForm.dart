import 'package:flutter/material.dart';

import 'HttpEchoClient.dart';
import 'HttpEchoServer.dart';
import 'Message.dart';

void main() async => runApp(MyApp());

HttpEchoServer _server;
HttpEchoClient _client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UX demo',
      home: MessageListScreen(),
    );
  }
}

class MessageList extends StatefulWidget {
  MessageList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MessageListState();
  }
}

class _MessageListState extends State<MessageList> with WidgetsBindingObserver {
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();

    const port = 6060;
    _server = HttpEchoServer(port);
    _server.start().then((_) {
      _client = HttpEchoClient(port);
      // 创建客户端后马上拉取历史记录
      _client.getHistory().then((list) {
        setState(() {
          messages.addAll(list);
        });
      });
      WidgetsBinding.instance.addObserver(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final subtitle = DateTime.fromMillisecondsSinceEpoch(msg.timestamp)
            .toLocal()
            .toIso8601String();
        return ListTile(
          title: Text(msg.msg),
          subtitle: Text(subtitle),
        );
      },
    );
  }

  void addMessage(Message msg) {
    setState(() {
      messages.add(msg);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      var server = _server;
      _server = null;
      server?.close();
    }
  }
}

class MessageListScreen extends StatelessWidget {
  final messageListKey =
      GlobalKey<_MessageListState>(debugLabel: 'messageListKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Echo client'),
      ),
      body: MessageList(key: messageListKey),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddMessageScreen()),
          );
          debugPrint('result = $result');

          if (_client == null) {
            return;
          }

          var msg = await _client.send(result);
          if (msg != null) {
            messageListKey.currentState.addMessage(msg);
          } else {
            debugPrint('fail to send $result');
          }
        },
        tooltip: 'Add message',
        child: Icon(Icons.add),
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
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Input message',
                  contentPadding: EdgeInsets.all(0.0),
                ),
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black54,
                ),
                controller: editController,
                autofocus: true,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              debugPrint('send: ${editController.text}');
//              final msg = Message(
//                editController.text,
//                DateTime.now().millisecondsSinceEpoch,
//              );
              Navigator.pop(context, editController.text);
            },
            onDoubleTap: () => debugPrint('double tapped'),
            onLongPress: () => debugPrint(' long pressed'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text('Send'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    editController.dispose();
  }
}

class AddMessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add message'),
      ),
      body: MessageForm(),
    );
  }
}
