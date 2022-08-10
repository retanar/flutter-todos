import 'dart:io';

import 'package:bloc_todo/models/todo.dart';
import 'package:bloc_todo/repositories/database_repo.dart';
import 'package:bloc_todo/repositories/mock_repo.dart';
import 'package:bloc_todo/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

final todoBloc = TodoBloc._internal(
    (Platform.isAndroid || Platform.isIOS) ? DatabaseRepository() : MockRepo()); // TODO: Change to real repo

class TodoBloc {
  final Repository _repo;
  final _todoFetcher = PublishSubject<List<Todo>>();

  Stream<List<Todo>> get todoList => _todoFetcher.stream;

  TodoBloc._internal(this._repo);

  Future<void> fetchTodos() async {
    _todoFetcher.sink.add(await _repo.getTodosList());
  }

  Future<void> addTodo(Todo todo) async {
    await _repo.addTodo(todo);
    await fetchTodos();
  }

  Future<void> removeTodo(Todo todo) async {
    await _repo.removeTodo(todo);
    await fetchTodos();
  }

  void dispose() {
    _todoFetcher.close();
  }
}
