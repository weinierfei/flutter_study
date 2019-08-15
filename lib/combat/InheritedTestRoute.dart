import 'package:flutter/material.dart';

class InheritedTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InheritedTestRouteState();
  }
}

class _InheritedTestRouteState extends State<InheritedTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _TestWidget(),
            ),
            RaisedButton(
              child: Text('Increment'),
              onPressed: () {
                setState(() {
                  ++count;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  final int data;

  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  /// 该方法方便子widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShareDataWidget);
  }

  /// 只共享数据  不触发子widget的didChangeDependencies调用
  static ShareDataWidget of2(BuildContext context) {
    return context
        .ancestorInheritedElementForWidgetOfExactType(ShareDataWidget)
        .widget;
  }

  ///该回调决定当data发生变化时 是否通知子widget中依赖data的widget
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    // 如果返回true 则子树中依赖本widget的子widget的state.didChangeDependencies方法会被调用
    return oldWidget.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return __TestWidgetState();
  }
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of2(context).data.toString());
  }

  /// 只要本widget使用了共享数据 该方法才会被调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("子widget的didChangeDependencies被调用");
  }
}
