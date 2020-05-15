import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/constants.dart';

class AddTodoPage extends StatefulWidget {
  static final String id = 'add_todo_page';

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  DateTime selectedDate = DateTime.now();

  DateTime now = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(now.year, now.month, now.day),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {}
    setState(() {
      selectedDate = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  OutlineButton.icon(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: Icon(Icons.event_note),
                    label: Text(
                      selectedDate.toString(),
                    ),
                  ),
                  TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      icon: Icon(Icons.note),
                      hintText: 'Add note',
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
