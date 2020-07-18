import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:todolist/model/todo.dart';

class TagsPage extends StatefulWidget {
  List<Todo> todos;

  TagsPage({this.todos});

  @override
  _TagsPageState createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  List<Todo> todos;

  @override
  void initState() {
    super.initState();
    todos = widget.todos;
  }

  var groupTags() {
    var groupedTags = groupBy(todos, (todo) => todo.tags.)
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
