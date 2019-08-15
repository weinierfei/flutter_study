import 'package:flutter/material.dart';

/// SingleChildScrollView类似与android中的scrollview
class SingleChildScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return Scrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: str
                .split("")
                .map((s) => Text(
                      s,
                      textScaleFactor: 2,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
