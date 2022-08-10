import 'package:mvp_todo/contracts/home_contract.dart';
import 'package:mvp_todo/models/todo.dart';

class HomePresenter implements Presenter {
  final View _view;
  final Model _model;

  HomePresenter(this._view, this._model);

  @override
  void addTodo(Todo todo) {
    _model.addTodo(todo);
    viewTodos();
  }

  @override
  void removeTodo(Todo todo) {
    _model.removeTodo(todo);
    viewTodos();
  }

  @override
  Future<void> viewTodos() async {
    final list = await _model.getTodosList();
    _view.showTodos(list);
  }
}
