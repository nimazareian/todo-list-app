import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoItemContainer extends StatelessWidget {
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isFinish;

  const TodoItemContainer({
    Key key,
    @required this.title,
    this.description,
    @required this.dueDate,
    @required this.isFinish,
  })  : assert(title != null),
        assert(dueDate != null),
        assert(isFinish != null),
        super(key: key);

  String formatDate() {
    return DateFormat("E, MMM d, y 'at' h:mma").format(dueDate);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                // offset: Offset(-5.0, 5.0),
                spreadRadius: 0.2,
                blurRadius: 1,
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Text(
                      formatDate(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
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
                child: Checkbox(value: isFinish, onChanged: null),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
