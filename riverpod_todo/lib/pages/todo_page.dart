import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';

class TodoRouteArguments {
  final Todo? todo;

  TodoRouteArguments(this.todo);
}

class TodoPage extends ConsumerWidget {
  const TodoPage({Key? key}) : super(key: key);

  static const route = 'todoPage';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
