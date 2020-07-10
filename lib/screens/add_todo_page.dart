import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todolist/constants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/model/todo_list.dart';

class AddTodoPage extends StatefulWidget {
  static final String id = 'add_todo_page';

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  DateTime now = DateTime.now();
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day + 1, 12, 00);
  final _timeFormat = DateFormat("E, MMM d, y 'at' h:mma");

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            return Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                runSpacing: 15,
                children: <Widget>[
                  Center(
                    child: Text(
                      'New Task',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 100,
                    child: TextField(
                      controller: _titleController,
                      autofocus: false,
                      autocorrect: true,
                      textAlign: TextAlign.center,
                      textCapitalization: TextCapitalization.sentences,
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      maxLines: null,
                      onChanged: (value) {},
                      onEditingComplete: () {},
                      decoration: InputDecoration(
                        labelText: 'What are you planning?',
                      ),
                    ),
                  ),
                  DateTimeField(
                    format: _timeFormat,
                    decoration: InputDecoration(
                      icon: Icon(Icons.alarm),
                      hintText: 'Add reminder',
                    ),
                    initialValue:
                        DateTime(now.year, now.month, now.day + 1, 12, 00),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: now,
                          initialDate: currentValue ?? now,
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime:
                              TimeOfDay.fromDateTime(currentValue ?? now),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                    onChanged: (date) => setState(() {
                      selectedDate = date;
                    }),
                  ),
                  TextField(
                    controller: _descriptionController,
                    maxLines: null,
                    decoration: InputDecoration(
                      icon: Icon(Icons.subject),
                      hintText: 'Add description',
                    ),
                  ),
                  TextField(
                    controller: _tagsController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      icon: Icon(Icons.bookmark_border),
                      hintText: 'Add tags',
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            //inkwell doesn't show circle when clicked on??
            onTap: () {
              try {
                Todo todo = Todo(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  tag: _tagsController.text,
                  dueDate: selectedDate,
                  isFinish: false,
                );

                Provider.of<TodoList>(context, listen: false).addTodo(todo);
                print('create button pressed');

                Navigator.pop(context);
              } catch (e) {
                print(e);
                //Todo pop up message that item is not filled / Error
              }
            },
            child: Container(
              height: 65,
              color: kBlueAccent,
              child: Center(
                child: Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
