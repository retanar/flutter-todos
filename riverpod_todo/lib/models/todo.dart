import 'package:flutter/material.dart';

@immutable
class Todo {
  final String title;
  final String contents;

  const Todo(this.title, this.contents);

  @override
  bool operator ==(Object other) {
    if (other is! Todo) return false;

    if (title != other.title) return false;
    if (contents != other.contents) return false;

    return true;
  }

  @override
  int get hashCode => Object.hash(title.hashCode, contents.hashCode);
}