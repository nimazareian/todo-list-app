import 'package:flutter/foundation.dart';

import 'database_helper.dart';

class Todo extends ChangeNotifier {
  final int id;
  String title;
  String description = '';
  List<String> tags = [];
  DateTime dueDate;
  DateTime dateCreated = DateTime.now(); //Is this constant or changing
  bool isFinish = false;

  Todo({
    this.id,
    @required this.title,
    this.description,
    @required this.dueDate,
    this.tags,
    this.isFinish,
    this.dateCreated,
  })  : assert(title != null),
        assert(dueDate != null);

  void updateTodo() {
    //
    notifyListeners();
  }

  final String columnTitle =
      'title'; //has to be same as one of the fields of todo
  final String columnId = 'id';
  final String columnDescription = 'description';
  final String columnDueDate = 'due_date';
  final String columnDateCreated = 'date_created';
  final String columnTags = 'tags';

  Map<String, dynamic> toMap() {
    return {
      columnTitle: this.title,
      columnDescription: this.description,
      columnDueDate: this.dueDate.toString(),
      columnDateCreated: this.dateCreated.toString(),
      // columnTags: this.dateCreated.toString(),
    };
  }
}
