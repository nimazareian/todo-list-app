import 'package:flutter/foundation.dart';

import 'database_helper.dart';

final String seperator = '|';

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

  Map<String, dynamic> toMap() {
    return {
      columnTitle: this.title,
      columnDescription: this.description,
      columnDueDate: this.dueDate.toString(),
      columnDateCreated: this.dateCreated.toString(),
      columnIsFinish: this.isFinish ? 1 : 0,
      columnTags: listToString(this.tags),
    };
  }

  // Concatenates all of the tags to one string with | as the seperator
  String listToString(List<String> list) {
    return list.join(seperator);
  }

  // Splits String using | as the seperator
  // if tagsStr is null, return empty list
  static List<String> stringToList(String tagsStr) {
    return tagsStr?.split(seperator) ?? [];
  }
}
