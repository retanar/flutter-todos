import 'package:bloc_todo/blocs/todo_bloc.dart';
import 'package:bloc_todo/models/todo.dart';
import 'package:bloc_todo/screens/todo_screen.dart';
import 'package:flutter/material.dart';

class TodoListItemView extends StatelessWidget {
  final Todo _todoState;

  const TodoListItemView(this._todoState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () {
          showDialog(context: context, builder: (context) => _showRemovePopup(context));
        },
        onTap: () {
          _navigateTodoScreen(context, _todoState);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_todoState.title, style: const TextStyle(fontSize: 24)),
            Text(
              _todoState.contents,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black38,
              ),
              maxLines: 1,
            ),
          ],
        ));
  }

  void _navigateTodoScreen(BuildContext context, Todo todoToEdit) {
    Navigator.pushNamed(context, TodoScreen.route, arguments: TodoRouteArguments(todoToEdit));
  }

  Widget _showRemovePopup(BuildContext context) {
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
              todoBloc.removeTodo(_todoState);
              Navigator.pop(context);
            }),
      ],
    );
  }
}
