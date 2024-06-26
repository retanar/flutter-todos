import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';
import '../models/todo_notifier.dart';
import '../views/todo_item_view.dart';
import 'todo_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> list = ref.watch(todosProvider);
    print("Build homepage, list size: ${list.length}");

    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO Riverpod"),
      ),
      body: buildList(list),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTodoScreen(context);
        },
        child: const Icon(Icons.create),
      ),
    );
  }

  Widget buildList(List<Todo> list) {
    return ListView.builder(
      itemCount: list.length,
      padding: const EdgeInsets.all(4),
      itemBuilder: (context, i) {
        return TodoListItemView(list[list.length - i - 1]);
      },
    );
  }

  void navigateTodoScreen(BuildContext context) {
    Navigator.pushNamed(context, TodoPage.route);
  }
}
