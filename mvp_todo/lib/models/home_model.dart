import 'dart:io';

import 'package:mvp_todo/contracts/home_contract.dart';
import 'package:mvp_todo/models/todo.dart';

class HomeModel implements Model {
  static const String _saveFileName = "todolist.txt";
  final Future<String> _dir;

  HomeModel(this._dir);

  List<Todo>? _todos;

  @override
  Future<List<Todo>> getTodosList() async {
    if (_todos != null) return _todos!;

    final saveFile = await _getSaveFile();
    if (!(await saveFile.exists())) {
      saveFile.createSync();
    }
    final lines = saveFile.readAsLinesSync();

    _todos = [];
    for (int i = 1; i < lines.length; i += 2) {
      _todos!.add(Todo(lines[i - 1], lines[i]));
    }

    return _todos!;
  }

  @override
  Future<void> addTodo(Todo todo) async {
    _todos?.add(todo);
    await _appendTodosList(todo);
  }

  @override
  Future<void> removeTodo(Todo todo) async {
    _todos?.remove(todo);
    await _saveTodosList();
  }

  Future<File> _getSaveFile() async {
    return File("${await _dir}/$_saveFileName");
  }

  Future<void> _saveTodosList() async {
    final saveFile = await _getSaveFile();
    saveFile.writeAsStringSync("");

    _todos?.forEach((todo) {
      saveFile.writeAsStringSync("${todo.title}\n${todo.contents}\n", mode: FileMode.append);
    });
    saveFile.writeAsStringSync("", mode: FileMode.append, flush: true);
  }

  Future<void> _appendTodosList(Todo newTodo) async {
    final saveFile = await _getSaveFile();

    saveFile.writeAsStringSync("${newTodo.title}\n${newTodo.contents}\n", mode: FileMode.append, flush: true);
  }
}
