import '../models/todo.dart';
import 'repository.dart';

class MockRepo implements Repository {
  final todoList = [
    const Todo("title1", "contents"),
    const Todo("title2", "contents"),
    const Todo("title3", "multiline contents asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf"),
  ];

  @override
  Future<void> addTodo(Todo todo) async {
    todoList.add(todo);
  }

  @override
  Future<List<Todo>> getTodosList() async {
    return todoList;
  }

  @override
  Future<void> removeTodo(Todo todo) async {
    todoList.remove(todo);
  }

}