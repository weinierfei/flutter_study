import 'package:flutter/material.dart';

/// 网格
class GridViewTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GridViewTestRouteState();
  }
}

class _GridViewTestRouteState extends State<GridViewTestRoute> {
  List<IconData> _icons = [];

  @override
  void initState() {
    super.initState();
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 每行三列
        childAspectRatio: 1.0, // 显示区域宽高相等
      ),
      itemCount: _icons.length,
      itemBuilder: (context, index) {
        if (index == _icons.length - 1 && _icons.length < 200) {
          _retrieveIcons();
        }
        return Icon(_icons[index]);
      },
    );
  }

  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.free_breakfast,
        ]);
      });
    });
  }
}
