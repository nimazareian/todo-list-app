import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:todolist/components/todo_item_container.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/screens/add_todo_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  static final String id = 'home_page';
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todos = [];
  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(),
      body: ListView.builder(
//        children: _todos, todo dsffdsdfs
        itemCount: 20,
        itemBuilder: (context, index) {
          return TodoItemContainer(
            title: 'Practice Piano',
            description: 'This is the desciption of the ',
            isFinish: false,
            dueDate: DateTime.now(),
          );
          //     ListTile(
          //   title: Text('title'),
          //   subtitle: Text('title'),
          //   enabled: true,
          //   contentPadding: EdgeInsets.symmetric(horizontal: 30),
          //   onTap: () {},
          //   trailing: Checkbox(
          //     value: checkBox,
          //     activeColor: kBlueAccent,
          //     onChanged: (bool b) {
          //       setState(() {
          //         checkBox = !checkBox;
          //       });
          //     },
          //   ),
          // );
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
                  onPressed: () {},
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
        //       child: Container(
        //   height: 75,
        //   child: FittedBox(
        //     child: FloatingActionButton(
        //       onPressed: () {
        //         setState(() {
        //           Navigator.pushNamed(context, AddTodoPage.id);
        //         });
        //       },
        //       tooltip: 'Add',
        //       child: Icon(
        //         Icons.add,
        //         size: 30,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
