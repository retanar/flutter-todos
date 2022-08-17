import 'package:bloc_todo/screens/home_screen.dart';
import 'package:bloc_todo/screens/todo_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO BLOC',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        TodoScreen.route: (context) => const TodoScreen(),
      },
      home: const HomeScreen(),
    );
  }
}
