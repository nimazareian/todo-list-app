import 'package:flutter/foundation.dart';

class Todo {
  final int id;
  String title;
  String description = '';
  String tag;
  DateTime dueDate;
  final DateTime dateCreated = DateTime.now(); //Is this constant or changing
  bool isFinish = false;

  Todo(
      {this.id,
      @required this.title,
      this.description,
      @required this.dueDate,
      this.tag,
      this.isFinish})
      : assert(title != null),
        assert(dueDate != null);
}
