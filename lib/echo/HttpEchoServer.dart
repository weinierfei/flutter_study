import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart';

import 'Message.dart';

class HttpEchoServer {
  final int port;
  HttpServer httpServer;
  Map<String, void Function(HttpRequest)> routes;

  static const GET = "GET";
  static const POST = "POST";
  final List<Message> messages = [];

  static const tableName = 'History';
  static const columnId = 'id';
  static const columnMsg = 'msg';
  static const columnTimestamp = 'timestamp';

  Database database;

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
    await _initDatabase();
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

  Future _initDatabase() async {
    var path = await getDatabasesPath() + '/history.db';
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        var sql = '''
      CREATE TABLE $tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnMsg TEXT,
      $columnTimestamp INTEGER
      )
      ''';
        await db.execute(sql);
      },
    );
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
      Message message = Message.create(body);
      messages.add(message);
      request.response.statusCode = HttpStatus.ok;

      var data = json.encode(message);
      // 把响应写回给服务端
      request.response.write(data);
      //存入数据库
      _storeMessage(message);
    } else {
      request.response.statusCode = HttpStatus.badRequest;
    }

    request.response.close();
  }

  Future _loadMessages() async {
    var list = await database.query(
      tableName,
      columns: [columnMsg, columnTimestamp],
      orderBy: columnId,
    );

    for (var item in list) {
      var message = Message.fromJson(item);
      messages.add(message);
    }
  }

  void _storeMessage(Message msg) {
    database.insert(tableName, msg.toJson());
  }

  void close() async {
    var server = httpServer;
    httpServer = null;
    await server?.close();

    var db = database;
    database = null;
    db?.close();
  }
}
