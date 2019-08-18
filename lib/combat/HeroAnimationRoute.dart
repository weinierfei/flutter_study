import 'package:flutter/material.dart';

/// 共享元素转换
class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: InkWell(
        child: Hero(
          tag: 'avatar', // 唯一标记 前后两个路由的tag值必须相同
          child: ClipOval(
            child: Image.asset(
              'images/avatar.png',
              width: 50,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, PageRouteBuilder(pageBuilder: (
            BuildContext context,
            Animation animation,
            Animation secondaryAnimation,
          ) {
            return FadeTransition(
              opacity: animation,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('原图'),
                ),
                body: HeroAnimationRouteB(),
              ),
            );
          }));
        },
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'avatar',
        child: Image.asset(
          'images/avatar.png',
        ),
      ),
    );
  }
}
