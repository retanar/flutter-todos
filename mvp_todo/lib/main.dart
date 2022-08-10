import 'package:flutter/material.dart';
import 'package:mvp_todo/screens/home.dart';
import 'package:mvp_todo/screens/make_note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO MVP',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        'makeTodo': (context) => const TodoView(),
      },
      home: const HomeView(),
    );
  }
}
