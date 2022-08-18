import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/models/todo_notifier.dart';

import '../models/todo.dart';

class TodoRouteArguments {
  final Todo? todo;

  TodoRouteArguments(this.todo);
}

class TodoPage extends ConsumerWidget {
  TodoPage({Key? key}) : super(key: key);

  static const route = 'todoPage';

  final titleFieldController = TextEditingController();
  final contentsFieldController = TextEditingController();

  late final Todo? todoArg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments as TodoRouteArguments?;
    todoArg = args?.todo;

    if (todoArg != null) {
      titleFieldController.text = todoArg!.title;
      contentsFieldController.text = todoArg!.contents;
    }

    return Scaffold(
      appBar: AppBar(
        title: todoArg == null ? const Text("Create Todo") : const Text("Edit Todo"),
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
        onPressed: () async {
          if (titleFieldController.text == '') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Title should not be empty")));
            return;
          }

          final todoNotifier = ref.read(todosProvider.notifier);
          final newTodo = Todo(titleFieldController.text, contentsFieldController.text);
          if (todoArg == null) {
            todoNotifier.addTodo(newTodo);
          } else {
            todoNotifier.replaceTodo(todoArg!, newTodo);
          }

          Navigator.pop(context);
        },
      ),
    );
  }
}
