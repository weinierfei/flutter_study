import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

/// dio库测试
class DioTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DioTestRouteState();
  }
}

class _DioTestRouteState extends State<DioTestRoute> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求完成
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            // 出错
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            // 请求成功 难道数据
            return ListView(
              children: response.data
                  .map<Widget>(
                    (e) => ListTile(
                      title: Text(e['full_name']),
                    ),
                  )
                  .toList(),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
