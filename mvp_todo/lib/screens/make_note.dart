import 'package:flutter/material.dart';
import 'package:mvp_todo/contracts/home_contract.dart';
import 'package:mvp_todo/models/todo.dart';

class TodoView extends StatefulWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TodoViewState();
}

class TodoViewState extends State<TodoView> {
  final titleFieldController = TextEditingController();
  final contentsFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final presenter = ModalRoute.of(context)?.settings.arguments as Presenter?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create TODO"),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleFieldController,
            maxLines: 1,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
            autofocus: true,
          ),
          TextField(
            controller: contentsFieldController,
            decoration: const InputDecoration(
              labelText: "Details",
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          if (titleFieldController.text == '') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Title should not be empty")));
            return;
          }

          presenter?.addTodo(Todo(titleFieldController.text, contentsFieldController.text));
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void dispose() {
    titleFieldController.dispose();
    contentsFieldController.dispose();
    super.dispose();
  }
}
