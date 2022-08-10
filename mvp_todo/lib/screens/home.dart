import 'package:flutter/material.dart';
import 'package:mvp_todo/contracts/home_contract.dart';
import 'package:mvp_todo/models/home_db_model.dart';
import 'package:mvp_todo/models/todo.dart';
import 'package:mvp_todo/presenters/home_presenter.dart';
import 'package:mvp_todo/widgets/todo_list_item_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> implements View {
  late final Presenter _presenter;
  List<Todo>? _todoList;

  @override
  void initState() {
    super.initState();
    _presenter = HomePresenter(this, HomeDbModel());    // HomeModel(getApplicationDocumentsDirectory().then((dir) => dir.path)
    _presenter.viewTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO MVP"),
      ),
      body: _todoList == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _todoList == null ? 0 : _todoList!.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, i) {
                return TodoListItemView(_todoList![i], _presenter);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddTodo,
        child: const Center(
            child: Icon(Icons.create)),
      ),
    );
  }

  void _onAddTodo() {
    Navigator.pushNamed(context, 'makeTodo', arguments: _presenter);
  }

  @override
  void showTodos(List<Todo> list) {
    setState(() {
      _todoList = list;
    });
  }
}
