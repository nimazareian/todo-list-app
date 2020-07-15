import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'package:todolist/constants.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/model/todo_list.dart';
import 'package:todolist/model/database_helper.dart';
import 'package:todolist/screens/home_page.dart';
import 'package:todolist/components/chips_wrap.dart';

class AddTodoPage extends StatefulWidget {
  static final String id = 'add_todo_page';
  Todo todo;

  AddTodoPage({this.todo});

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  Todo todo;
  List<String> tags = List<String>();
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  DateTime now = DateTime.now();
  DateTime initialDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day + 1, 12, 00);
  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day + 1, 12, 00);

  final _timeFormat = DateFormat("E, MMM d, y 'at' h:mma");

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    //check if editing an existing todo
    if (widget.todo != null) {
      todo = widget.todo;
      _editingTodoMode(todo);
      _isEditing = true;
    }
  }

  _editingTodoMode(Todo todo) {
    _titleController..text = todo.title;
    _descriptionController..text = todo.description;
    tags = todo.tags; // if not null
    initialDate = todo.dueDate;
    selectedDate = todo.dueDate;
  }

  void _addTag() {
    if (_tagsController.text != null &&
        _tagsController.text != '' &&
        !_tagsController.text.contains(seperator)) {
      setState(() {
        tags.add(_tagsController.text);
        _tagsController.clear();
      });
    }
  }

  Future<void> _addTodo() async {
    try {
      if (_isEditing) {
        todo
          ..title = _titleController.text
          ..description = _descriptionController.text
          ..tags = tags
          ..dueDate = selectedDate;
        //SHOULD CHECK IF todo is already in list
        await _databaseHelper.update(todo);
      } else {
        todo = Todo(
          title: _titleController.text,
          description: _descriptionController.text,
          tags: tags,
          dueDate: selectedDate,
          isFinish: false,
        );
        await _databaseHelper.insertTodo(todo);
      }

      Provider.of<TodoList>(context, listen: false).addTodo(todo);
      print('create button pressed');

      Navigator.pushNamed(context, HomePage.id);
    } catch (e) {
      print(e);
      //Todo pop up message that item is not filled / Error
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

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
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                    maxLines: null,
                    decoration: InputDecoration(
                      icon: Icon(Icons.subject),
                      hintText: 'Add description',
                    ),
                  ),
                  DateTimeField(
                    format: _timeFormat,
                    decoration: InputDecoration(
                      icon: Icon(Icons.alarm),
                      hintText: 'Add reminder',
                    ),
                    initialValue: initialDate,
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
                    controller: _tagsController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      icon: Icon(Icons.bookmark_border),
                      hintText: 'Add tags',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _addTag,
                      ),
                    ),
                  ),
                  ChipsWrap(
                    tags: tags,
                    isEditing: true,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            //inkwell doesn't show circle when clicked on?? Blue color BG?
            onTap: _addTodo,
            child: Container(
              height: 65,
              color: kBlueAccent,
              child: Center(
                child: Text(
                  _isEditing ? 'Update' : 'Create',
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
