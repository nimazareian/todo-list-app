import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
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
//      appBar: AppBar(),
      body: ListView.builder(
//        children: _todos, todo dsffdsdfs
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Container(
              // height: 100,
              // color: Colors.grey,
              // decoration: BoxDecoration(boxShadow: <BoxShadow>[
              //   BoxShadow(
              //     color: Colors.black54,
              //     // spreadRadius: 5,
              //     blurRadius: 2,
              //   ),
              // ]),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      // offset: Offset(-5.0, 5.0),
                      spreadRadius: 0.5,
                      blurRadius: 2,
                    )
                  ]),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'This is the title of the todo',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'This is the description of the todo. Today I have alot of work to do boiiiiii iiiiii iiiiiiii iiiiiiii fsdh jdsf sadklhlk sajkdh',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '16:00 tomorrow',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
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
                      child: Checkbox(value: true, onChanged: null),
                    ),
                  ),
                ],
              ),
            ),
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
          color: Colors.transparent,
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
