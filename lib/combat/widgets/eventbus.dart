// 订阅者回调签名
typedef void EventCallback(arg);

class EventBus {
// 私有构造函数
  EventBus._internal();

  //单例
  static EventBus _singleton = EventBus._internal();

//工厂构造函数
  factory EventBus() => _singleton;

  // 保存事件订阅者队列 : key:事件名 value:对应事件的订阅者队列
  var _emap = Map<Object, List<EventCallback>>();

  // 添加订阅者
  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) {
      return;
    }
    _emap[eventName] ??= List<EventCallback>();
    _emap[eventName].add(f);
  }

  // 移除订阅者
  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) {
      return;
    }

    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  // 触发事件 事件触发后该事件的所有订阅者都会被调用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) {
      return;
    }
    int length = list.length - 1;
    // 反向遍历: 防止订阅者在回调中一尺自身带来的下标错位
    for (var i = length; i > -1; --i) {
      list[i](arg);
    }
  }

  var bus = EventBus();
}
