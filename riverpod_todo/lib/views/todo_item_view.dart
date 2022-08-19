import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';
import '../pages/todo_page.dart';

class TodoListItemView extends ConsumerWidget {
  final Todo _todoState;

  const TodoListItemView(this._todoState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        _navigateTodoScreen(context, _todoState);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _todoState.title,
                style: const TextStyle(fontSize: 28),
                maxLines: 1,
              ),
              Text(
                _todoState.contents,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black38,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTodoScreen(BuildContext context, Todo todoToEdit) {
    Navigator.pushNamed(context, TodoPage.route, arguments: TodoRouteArguments(todoToEdit));
  }
}
