import 'package:bloc_todo/blocs/todo_bloc.dart';
import 'package:bloc_todo/models/todo.dart';
import 'package:flutter/material.dart';

class TodoRouteArguments {
  final Todo? todo;

  TodoRouteArguments(this.todo);
}

class TodoScreen extends StatefulWidget {
  static const route = 'todoScreen';

  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {
  final titleFieldController = TextEditingController();
  final contentsFieldController = TextEditingController();

  late Todo? todoArg;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as TodoRouteArguments?;
    todoArg = args?.todo;

    if (todoArg != null) {
      titleFieldController.text = todoArg!.title;
      contentsFieldController.text = todoArg!.contents;
    }

    return Scaffold(
      appBar: AppBar(
        title: todoArg == null ? const Text("Create TODO") : const Text("Edit Todo"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleFieldController,
              maxLines: 1,
              decoration: const InputDecoration.collapsed(
                hintText: "Title",
              ),
              autofocus: true,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            Expanded(
                child: TextField(
              textAlignVertical: TextAlignVertical.top,
              controller: contentsFieldController,
              decoration: const InputDecoration(
                hintText: "Details",
              ),
              minLines: null,
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          if (titleFieldController.text == '') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Title should not be empty")));
            return;
          }

          todoBloc.addTodo(Todo(titleFieldController.text, contentsFieldController.text));

          Navigator.pop(context);
        },
      ),
    );
  }
}
