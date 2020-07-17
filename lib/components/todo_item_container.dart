import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/components/chips_wrap.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/model/database_helper.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/screens/add_todo_page.dart';

class TodoItemContainer extends StatefulWidget {
  final Todo todo;

  TodoItemContainer({
    Key key,
    @required this.todo,
  })  : assert(todo != null),
        super(key: key);

  @override
  _TodoItemContainerState createState() => _TodoItemContainerState();
}

class _TodoItemContainerState extends State<TodoItemContainer> {
  Todo todo;
  bool isSelected = false;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  initState() {
    super.initState();
    todo = widget.todo;
  }

  void taskStateChanged() {
    //draw a line through the title of todo or make it more transparent
    //or viseversa
  }

  String formatDate() {
    return DateFormat("E, MMM d, y 'at' h:mma").format(todo.dueDate);
  }

  void _showTodoDetail() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          // minChildSize: 0.1,
          // maxChildSize: 1,
          // initialChildSize: 0.3,
          builder: (context, controller) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            todo.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.delete,
                        //     color: kLightGrey, //Colors.black54,
                        //   ),
                        //   onPressed: () {
                        //     setState(() {
                        //       //deletes from the database, but stay on screen
                        //       _databaseHelper.delete(todo.id);
                        //     });
                        //   },
                        // ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: kLightGrey, //Colors.black54,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTodoPage(
                                  todo: todo,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      todo.description,
                      style: kTodoDescriptionTextStyle,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      // height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kPurple,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          formatDate(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ChipsWrap(
                      tags: todo.tags,
                      isEditing: false,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                // offset: Offset(-5.0, 5.0),
                spreadRadius: 0.2,
                blurRadius: 1,
              )
            ]),
        child: InkWell(
          onTap: () {
            _showTodoDetail();
          },
          onLongPress: () {
            // implement that pops up a delete button
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              todo.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                decoration: todo.isFinish
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              todo.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: kTodoDescriptionTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Text(
                          formatDate(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Checkbox(
                      value: todo.isFinish,
                      onChanged: (bool newValue) {
                        setState(() {
                          todo.isFinish = newValue;
                          _databaseHelper.update(todo);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
