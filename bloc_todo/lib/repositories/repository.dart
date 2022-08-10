import 'package:bloc_todo/models/todo.dart';

abstract class Repository {
  Future<void> addTodo(Todo todo);

  Future<void> removeTodo(Todo todo);

  Future<List<Todo>> getTodosList();
}