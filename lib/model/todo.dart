import 'package:flutter/foundation.dart';

class Todo extends ChangeNotifier {
  final int id;
  String title;
  String description = '';
  List<String> tags = [];
  DateTime dueDate;
  final DateTime dateCreated = DateTime.now(); //Is this constant or changing
  bool isFinish = false;

  Todo(
      {this.id,
      @required this.title,
      this.description,
      @required this.dueDate,
      this.tags,
      this.isFinish})
      : assert(title != null),
        assert(dueDate != null);

  void updateTodo() {
    //
    notifyListeners();
  }
}
