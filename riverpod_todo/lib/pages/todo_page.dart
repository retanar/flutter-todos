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

  final _titleFieldController = TextEditingController();
  final _contentsFieldController = TextEditingController();

  late final Todo? _todoArg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments as TodoRouteArguments?;
    _todoArg = args?.todo;

    if (_todoArg != null) {
      _titleFieldController.text = _todoArg!.title;
      _contentsFieldController.text = _todoArg!.contents;
    }

    return Scaffold(
      appBar: AppBar(
        title: _todoArg == null ? const Text("Create Todo") : const Text("Edit Todo"),
        actions: [
          if (_todoArg != null)
            IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => _showRemovePopup(context, ref));
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleFieldController,
              maxLines: 1,
              decoration: const InputDecoration.collapsed(
                hintText: "Title",
              ),
              autofocus: true,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: TextField(
              textAlignVertical: TextAlignVertical.top,
              controller: _contentsFieldController,
              decoration: const InputDecoration(
                hintText: "Details",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 20),
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
          if (_titleFieldController.text == '') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Title should not be empty")));
            return;
          }

          final todoNotifier = ref.read(todosProvider.notifier);
          final newTodo = Todo(_titleFieldController.text, _contentsFieldController.text);
          if (_todoArg == null) {
            todoNotifier.addTodo(newTodo);
          } else {
            todoNotifier.replaceTodo(_todoArg!, newTodo);
          }

          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _showRemovePopup(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Remove TODO?"),
      actions: [
        TextButton(
            child: const Text("NO"),
            onPressed: () {
              Navigator.pop(context);
            }),
        TextButton(
            child: const Text("YES"),
            onPressed: () {
              ref.read(todosProvider.notifier).removeTodo(_todoArg!);
              // pop the dialog
              Navigator.pop(context);
              // pop the page
              Navigator.pop(context);
            }),
      ],
    );
  }
}
