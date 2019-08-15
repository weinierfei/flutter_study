import 'dart:collection';

import 'package:first_flutter_app/combat/widgets/provider.dart';
import 'package:flutter/material.dart';

/// 跨组件状态共享
class ProviderTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProviderTestRouteState();
  }
}

class _ProviderTestRouteState extends State<ProviderTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Builder(
                builder: (context) {
                  return Consumer<CartModel>(
                    builder: (context, cart) => Text('总价: ${cart.totalPrice}'),
                  );
                },
              ),
              Builder(
                builder: (context) {
                  print("RaisedButton build");
                  return RaisedButton(
                    child: Text('添加商品'),
                    onPressed: () {
                      ChangeNotifierProvider.of<CartModel>(context,listen: false)
                          .add(Item(20.0, 1));
                    },
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  // 禁止修改购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

// 购物车中的商品总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将商品添加到购物车
  void add(Item item) {
    _items.add(item);
    // 通知订阅者
    notifyListeners();
  }
}

class Item {
  double price; // 单价
  int count; // 数量

  Item(this.price, this.count);
}
