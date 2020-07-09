import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'screens/home_page.dart';
import 'screens/add_todo_page.dart';

const appName = 'To Do List';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData.light().copyWith(
        primaryColor: kBlueAccent,
        accentColor: kBlueAccent,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: kPurple, //kBlueAccent,
          elevation: 2,
        ),
        iconTheme: IconThemeData(
          color: Colors.white, //kPurple,
        ),
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        AddTodoPage.id: (context) => AddTodoPage(),
      },
    );
  }
}
