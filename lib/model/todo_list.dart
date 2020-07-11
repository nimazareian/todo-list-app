import 'package:flutter/cupertino.dart';

import 'todo.dart';

class TodoList extends ChangeNotifier {
  List<Todo> todoList = []; //all tasks

  addTodo(Todo todo) {
    todoList.add(todo);
    sortListDate();
    for (Todo todo in todoList) {
      print(todo.title);
    }
    //We have to notify listeners
    notifyListeners();
  }

  //currently messes up the list
  //sorts the list, but when listview builder tries to add it, it adds the last item. Doesnt rebuild the entire list tree
  //how to insert an item in middle of listview with listview builder
  void sortListDate() {
    todoList.sort((a, b) {
      var aDate = a.dueDate;
      var bDate = b.dueDate;
      return aDate.compareTo(bDate);
    });
  }
}
