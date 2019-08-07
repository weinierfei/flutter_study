import 'package:first_flutter_app/geektime/UpdateitemModel.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

bool _isLight = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: _isLight ? Brightness.light : Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('控件组合'),
        ),
        body: UpdatedItem(
          model: UpdateItemModel(
              Icons.map,
              "谷歌地图",
              '39.5',
              "2018年6月5日",
              "Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.",
              'Version 3.6.1'),
        ),
      ),
    );
  }
}

class UpdatedItem extends StatelessWidget {
  final UpdateItemModel model;
  final VoidCallback onPressed;

  UpdatedItem({Key key, this.model, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTopRow(context),
        BottomRow(model: model,),
      ],
    );
  }

  Widget buildTopRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              "https://x0.ifengimg.com/ucms/2019_30/FDD671A9E7E49052A594A8EC7D29B3578EA8121A_w632_h637.jpg",
              width: 80,
              height: 80,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.appName,
                maxLines: 1,
              ),
              Text(
                model.appDate,
                maxLines: 1,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: FlatButton(
            child: Text("open"),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }

  Widget buildBottomRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.appDescription),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text("${model.appVersion} . ${model.appSize} MB"),
          ),
        ],
      ),
    );
  }
}

class BottomRow extends StatefulWidget {
  final UpdateItemModel model;

  BottomRow({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BottomRowState();
  }
}

class _BottomRowState extends State<BottomRow> {
  bool open = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: Text(
                  widget.model.appDescription,
                  maxLines: open ? 100 : 2,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      open = !open;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                        Colors.white,
                        Colors.grey,
                      ]),
                    ),
                    child: Text(
                      "More",
                      style: TextStyle(
                        color: Color(0xFF007AFE),
                        fontSize: 14,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text("${widget.model.appVersion} . ${widget.model.appSize} MB"),
          ),
        ],
      ),
    );
  }
}
