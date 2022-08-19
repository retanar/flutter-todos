import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/database_repo.dart';
import '../repositories/mock_repo.dart';
import '../repositories/repository.dart';
import 'todo.dart';

final todosProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(Platform.isAndroid || Platform.isIOS ? DatabaseRepository() : MockRepo());
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  final Repository _repo;

  TodoNotifier(this._repo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    state = await _repo.getTodosList();
  }

  Future<void> addTodo(Todo todo) async {
    await _repo.addTodo(todo);
    await loadTodos();
  }

  Future<void> replaceTodo(Todo oldTodo, Todo newTodo) async {
    if (oldTodo == newTodo) return;
    await _repo.removeTodo(oldTodo);
    await addTodo(newTodo);
  }

  Future<void> removeTodo(Todo todo) async {
    await _repo.removeTodo(todo);
    await loadTodos();
  }
}
