import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'Message.dart';

class HttpEchoServer {
  final int port;
  HttpServer httpServer;
  Map<String, void Function(HttpRequest)> routes;
  String historyFilepath;

  static const GET = "GET";
  static const POST = "POST";
  final List<Message> messages = [];

  HttpEchoServer(this.port) {
    _initRoutes();
  }

  void _initRoutes() {
    routes = {
      '/history': _history,
      '/echo': _echo,
    };
  }

  Future start() async {
    historyFilepath = await _historyPath();
    // 启动服务前 先加载历史记录
    await _loadMessages();
    // 创建一个httpServer
    httpServer = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    // 开始监听客户请求
    return httpServer.listen((request) {
      final path = request.uri.path;
      final handler = routes[path];
      if (handler != null) {
        handler(request);
      } else {
        // 给客户端一个404
        request.response.statusCode = HttpStatus.notFound;
        request.response.close();
      }
    });
  }

  void _history(HttpRequest request) {
    if (request.method != GET) {
      _unsupportedMethod(request);
      return;
    }

    String historyData = json.encode(messages);
    request.response.write(historyData);
    request.response.close();
  }

  _unsupportedMethod(HttpRequest request) {
    request.response.statusCode = HttpStatus.methodNotAllowed;
    request.response.close();
  }

  void _echo(HttpRequest request) async {
    if (request.method != POST) {
      _unsupportedMethod(request);
      return;
    }

    // 获取从客户端post请求的body
    String body = await request.transform(utf8.decoder).join();
    if (body != null) {
      var message = Message.create(body);
      messages.add(message);
      request.response.statusCode = HttpStatus.ok;

      var data = json.encode(message);
      // 把响应写回给服务端
      request.response.write(data);
    } else {
      request.response.statusCode = HttpStatus.badRequest;
    }

    request.response.close();

    _storeMessage();
  }

  void close() async {
    var server = httpServer;
    httpServer = null;
    await server?.close();
  }

  Future<String> _historyPath() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    return directory.path + '/messages.json';
  }

  Future<bool> _storeMessage() async {
    try {
      final data = json.encode(messages);
      final file = File(historyFilepath);
      final exists = await file.exists();
      if (!exists) {
        await file.create();
      }

      file.writeAsString(data);
      return true;
    } catch (e) {
      print("_storeMessage: $e");
      return false;
    }
  }

  Future _loadMessages() async {
    try {
      var file = File(historyFilepath);
      var exists = await file.exists();
      if (!exists) {
        return;
      }
      var content = await file.readAsString();
      var list = json.decode(content);
      for (var msg in list) {
        var message = Message.fromJson(msg);
        messages.add(message);
      }
    } catch (e) {
      print('_loadMessages : $e');
    }
  }
}
