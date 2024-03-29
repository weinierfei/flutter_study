import 'package:sqflite/sqflite.dart';

void main() {
  Todo todo = Todo('11111', '22222');
  todo.foo();
}

class Todo {
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnContent = 'content';

  int id;
  String title;
  String content;

  Todo(this.title, this.content, [this.id]);

  Todo.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        title = map[columnTitle],
        content = map[columnContent];

  Map<String, dynamic> toMap() => {
        columnTitle: title,
        columnContent: content,
      };

  @override
  String toString() {
    return 'Todo{id=$id, title=$title, content=$content}';
  }

  void foo() async {
    const table = 'Todo';
    var path = await getDatabasesPath() + '/demo.db';
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        var sql = '''
        CREATE TABLE $table ('            
       ${Todo.columnId} INTEGER PRIMARY KEY,'
       ${Todo.columnTitle} TEXT,'
       ${Todo.columnContent} TEXT'
       )
       ''';
        await db.execute(sql);
      },
    );
    // 为了让每次运行结果都一样,先把数据清掉
    await database.delete(table);

    var todo1 = Todo('Flutter', 'Learn Flutter widgets.');
    var todo2 = Todo('Flutter', 'Learn how to  IO int Flutter.');
    // 插入数据
    await database.insert(table, todo1.toMap());
    await database.insert(table, todo2.toMap());

    List<Map> list = await database.query(table);
    print('${list.toString()}');

    // 重新赋值  这样todo.id 才不会为0
    todo1 = Todo.fromMap(list[0]);
    todo2 = Todo.fromMap(list[1]);
    print('query: todo1 = $todo1');
    print('query: todo2 = $todo2');
    todo1.content += 'Come on';
    todo2.content += 'I\'m tried';

    // 使用事务
    await database.transaction((txn) async {
      await txn.update(table, todo1.toMap(),
          where: '${Todo.columnId} = ?', whereArgs: [todo1.id]);

      await txn.update(table, todo2.toMap(),
          where: '${Todo.columnId} = ?', whereArgs: [todo2.id]);
    });

    list = await database.query(table);
    for (var map in list) {
      var todo = Todo.fromMap(map);
      print('updated: todo = $todo');
    }

    // 关闭数据库
    await database.close();
  }
}
