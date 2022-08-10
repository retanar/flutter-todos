import 'package:mvp_todo/models/todo.dart';

abstract class Model {
  Future<void> addTodo(Todo todo);

  Future<void> removeTodo(Todo todo);

  Future<List<Todo>> getTodosList();
}

abstract class Presenter {
  void addTodo(Todo todo);

  void removeTodo(Todo todo);

  Future<void> viewTodos();
}

abstract class View {
  void showTodos(List<Todo> list);
}
