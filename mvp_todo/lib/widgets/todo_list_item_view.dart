import 'package:flutter/material.dart';
import 'package:mvp_todo/contracts/home_contract.dart';
import 'package:mvp_todo/models/todo.dart';

class TodoListItemView extends StatelessWidget {
  final Presenter _presenter;
  final Todo _todoState;

  const TodoListItemView(this._todoState, this._presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () {
          showDialog(context: context, builder: (context) => _showRemovePopup(context));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_todoState.title, style: const TextStyle(fontSize: 24)),
            Text(_todoState.contents, style: const TextStyle(fontSize: 18, color: Colors.black38)),
          ],
        ));
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
              _presenter.removeTodo(_todoState);
              Navigator.pop(context);
            }),
      ],
    );
  }
}
