import 'package:mvp_todo/contracts/home_contract.dart';
import 'package:mvp_todo/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class HomeDbModel implements Model {
  static const _tableName = "todos";
  static const _createDbSql = "CREATE TABLE $_tableName ("
      "title TEXT NOT NULL UNIQUE,"
      "contents TEXT)";

  final Future<Database> _database;

  HomeDbModel({String dbName = "todo.db"})
      : _database = getDatabasesPath().then((path) => openDatabase(
              "$path/$dbName",
              version: 1,
              onCreate: (db, version) => db.execute(_createDbSql),
            ));

  Map<String, Object> _todoToMap(Todo todo) {
    return {"title": todo.title, "contents": todo.contents};
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final db = await _database;

    await db.insert(_tableName, _todoToMap(todo), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Todo>> getTodosList() async {
    final db = await _database;

    final todoList = db.query(_tableName).then((mapList) {
      return mapList.map((map) => Todo(map["title"] as String, map["contents"] as String)).toList();
    });
    return todoList;
  }

  @override
  Future<void> removeTodo(Todo todo) async {
    final db = await _database;

    await db.delete(_tableName, where: "title = ?", whereArgs: [todo.title]);
  }
}
