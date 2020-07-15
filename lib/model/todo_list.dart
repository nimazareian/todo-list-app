import 'package:flutter/cupertino.dart';

import 'todo.dart';

class TodoList extends ChangeNotifier {
  List<Todo> todoList = []; //all tasks

  addTodo(Todo todo) {
    if (todoList.contains(todo)) {
      print('already contains it');
    } else {
      todoList.add(todo);
      _sortListDate(); //////////////////////////// SOrt by day
      for (Todo todo in todoList) {
        print(todo.title);
      }
      //We have to notify listeners
      notifyListeners();
    }
  }

  // sort by due date of todo
  void _sortListDate() {
    todoList.sort((a, b) {
      var aDate = a.dueDate;
      var bDate = b.dueDate;
      return aDate.compareTo(bDate);
    });
  }
}
