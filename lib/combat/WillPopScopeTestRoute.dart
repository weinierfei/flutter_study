import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

/// 返回拦截
class WillPopScopeTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WillPopScopeTestRouteState();
  }
}

class _WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt; //最后一次点击时间

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: WillPopScope(
        child: Container(
          alignment: Alignment.center,
          child: Text("1s内连续按两次返回键退出"),
        ),
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 1)) {
            // 两次点击间隔超过1s重新计算
            _lastPressedAt = DateTime.now();

            showToast("再按一次推荐本页");
            return false;
          } else {
            return true;
          }
        },
      ),
    );
  }
}
