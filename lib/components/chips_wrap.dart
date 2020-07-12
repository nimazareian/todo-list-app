import 'package:flutter/material.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/model/todo.dart';

class ChipsWrap extends StatefulWidget {
  final List<String> tags;

  ChipsWrap({@required this.tags});

  @override
  _ChipsWrapState createState() => _ChipsWrapState();
}

class _ChipsWrapState extends State<ChipsWrap> {
  List<String> tags;

  @override
  void initState() {
    super.initState();
    tags = widget.tags;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: List<Widget>.generate(
        tags.length,
        (index) {
          return Chip(
            label: Text(
              tags[index],
              style: TextStyle(
                color: kLightGrey,
              ),
            ),
            backgroundColor: kChipColors[index % kChipColors.length],
            onDeleted: () {
              setState(() {
                tags.removeAt(index);
              });
            },
            deleteIconColor: Colors.white54,
          );
        },
      ),
    );
  }
}
