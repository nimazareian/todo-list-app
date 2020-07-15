import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:todolist/components/todo_item_container.dart';
import 'package:todolist/components/custom_app_bar.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/main.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/model/todo_list.dart';
import 'package:todolist/model/database_helper.dart';
import 'package:todolist/screens/add_todo_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  static final String id = 'home_page';
}

class _HomePageState extends State<HomePage> {
  bool checkBox = false;
  Todo clickedTodo;

  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Todo> _todoDatabase = [];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  void initDatabase() async {
    // await DatabaseHelper.deleteData();
    List<Todo> todoList = await _databaseHelper.getAllTodo();
    setState(() {
      _todoDatabase = todoList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(),
      body: Consumer<TodoList>(
        builder: (context, todos, child) {
          return CustomScrollView(
            slivers: <Widget>[
              CustomAppBar(),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return TodoItemContainer(
                      todo: _todoDatabase[index], //todos.todoList[index],
                    );
                  },
                  childCount: _todoDatabase
                      .length, //todos.todoList.length, //todo.todoList.length,
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: kBlueAccent,
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: IconButton(
                  icon: Icon(Icons.list),
                  iconSize: 30,
                  onPressed: () {
                    print('nb');
                  },
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.access_alarm),
                  iconSize: 30,
                  onPressed: () async {
                    // List<Todo> list = await _databaseHelper.getAllTodo();
                    await DatabaseHelper.deleteData();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: OpenContainer(
        transitionType: ContainerTransitionType.fade,
        closedShape: CircleBorder(),
        closedColor: kPurple,
        openBuilder: (BuildContext context, VoidCallback _) {
          return AddTodoPage();
        },
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return Container(
            height: 75,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: openContainer,
                tooltip: 'Add',
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
