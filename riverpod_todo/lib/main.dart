import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/todo_page.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO Riverpod',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        TodoPage.route: (context) => TodoPage(),
      },
      home: const HomePage(),
    );
  }
}
