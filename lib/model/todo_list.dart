import 'package:flutter/cupertino.dart';

import 'todo.dart';

class TodoList extends ChangeNotifier {
  List<Todo> todoList = []; //all tasks

  addTodo(Todo todo) {
    todoList.add(todo);

    //We have to notify listeners
    notifyListeners();
  }
}
