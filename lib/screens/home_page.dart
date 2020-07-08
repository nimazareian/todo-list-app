import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:todolist/components/todo_item_container.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/screens/add_todo_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  static final String id = 'home_page';
}

class _HomePageState extends State<HomePage> {
  List<TodoItemContainer> _todos = [];
  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ListView.builder(
//        children: _todos, todo dsffdsdfs
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('title'),
            subtitle: Text('title'),
            enabled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            onTap: () {},
            trailing: Checkbox(
              value: checkBox,
              activeColor: kBlueAccent,
              onChanged: (bool b) {
                setState(() {
                  checkBox = !checkBox;
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(
            Icons.list,
            size: 30,
          ),
          Icon(
            Icons.add,
            size: 30,
          ),
          Icon(
            Icons.access_alarm,
            size: 30,
          ),
        ],
        onTap: (index) {
          //
        },
        animationDuration: Duration(
          milliseconds: 300,
        ),
        color: kBlueAccent,
        backgroundColor: Colors.transparent,
        height: 60,
      ),
    );
  }
}
