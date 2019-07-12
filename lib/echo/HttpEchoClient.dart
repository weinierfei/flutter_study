import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Message.dart';

class HttpEchoClient {
  final int port;
  final String host;

  HttpEchoClient(this.port) : host = 'http://localhost:$port';

  Future<Message> send(String msg) async {
    final response = await http.post(host + '/echo', body: msg);
    if (response.statusCode == 200) {
      Map<String, dynamic> msgJson = json.decode(response.body);
      var message = Message.fromJson(msgJson);
      return message;
    } else {
      return null;
    }
  }

  Future<List<Message>> getHistory() async {
    try {
      final response = await http.get(host + '/history');
      if (response.statusCode == 200) {
        return _decodeHistory(response.body);
      }
    } catch (e) {
      print('getHistory: $e');
    }
    return null;
  }

  List<Message> _decodeHistory(String response) {
    var messages = json.decode(response);
    var list = <Message>[];
    for (var msgJson in messages) {
      list.add(Message.fromJson(msgJson));
    }
    return list;
  }
}
