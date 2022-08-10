import 'package:bloc_todo/blocs/todo_bloc.dart';
import 'package:bloc_todo/models/todo.dart';
import 'package:bloc_todo/screens/todo_screen.dart';
import 'package:bloc_todo/views/todo_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    todoBloc.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO BLOC"),
      ),
      body: StreamBuilder<List<Todo>>(
        stream: todoBloc.todoList,
        builder: ((context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final result = snapshot.data!;
          return buildList(result);
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateTodoScreen,
        child: const Icon(Icons.create),
      ),
    );
  }

  Widget buildList(List<Todo> list) {
    return ListView.builder(
      itemCount: list.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, i) {
        return TodoListItemView(list[list.length-i-1]);
      },
    );
  }

  void navigateTodoScreen() {
    Navigator.pushNamed(context, TodoScreen.route);
  }

  @override
  void dispose() {
    todoBloc.dispose();
    super.dispose();
  }
}
