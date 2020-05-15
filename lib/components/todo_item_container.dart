import 'package:flutter/material.dart';

class TodoItemContainer extends StatelessWidget {
  const TodoItemContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade300,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Call Max',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                '20:15 . April 29',
              ),
            ],
          ),
          Checkbox(
            value: true,
            onChanged: (bool b) {},
          ),
        ],
      ),
    );
  }
}
