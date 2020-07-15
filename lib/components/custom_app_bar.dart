import 'package:flutter/material.dart';
import 'package:todolist/constants.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(appName),
      centerTitle: false,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      expandedHeight: 150,
      floating: false,
      pinned: true,
      // snap: true,
      flexibleSpace: FlexibleSpaceBar(
          // background: Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Padding(
          //     padding: EdgeInsets.all(20),
          //     child: Text(
          //       'Tuesday, March 16',
          //       style: TextStyle(
          //         fontSize: 30,
          //         fontStyle: FontStyle.italic,
          //         fontWeight: FontWeight.w900,
          //         color: Colors.white70,
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
