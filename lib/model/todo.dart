import 'package:flutter/foundation.dart';

class Todo {
  final int id;
  String title;
  String description = '';
  DateTime dueDate;
  final DateTime dateCreated = DateTime.now(); //Is this constant or changing
  bool isFinish = false;

  Todo(
      {@required this.id,
      @required this.title,
      this.description,
      @required this.dueDate,
      this.isFinish})
      : assert(id != null),
        assert(title != null),
        assert(description != null),
        assert(dueDate != null),
        assert(isFinish != null);
}
