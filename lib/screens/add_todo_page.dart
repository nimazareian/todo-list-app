import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/constants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AddTodoPage extends StatefulWidget {
  static final String id = 'add_todo_page';

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  DateTime selectedDate;
  DateTime now = DateTime.now();
  final _timeFormat = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.close),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'New Task',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.black,
//                    fontWeight: FontWeight.bold,
                          fontSize: 30,
//                    fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 100,
                    child: TextField(
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
                    maxLines: 1,
                    decoration: InputDecoration(
                      icon: Icon(Icons.note),
                      hintText: 'Add description',
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print('Create button');
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
//      appBar: AppBar(),
    );
  }
}
