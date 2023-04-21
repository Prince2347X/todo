import 'package:flutter/material.dart';

import 'package:todo/objects/todo.dart';

class TodoTile extends StatefulWidget {
  final TodoObject todo;
  const TodoTile({super.key, required this.todo});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
      child: CheckboxListTile(
        checkColor: Colors.white,
        title: Text(widget.todo.title),
        tileColor: Colors.white,
        value: widget.todo.isCompleted,
        onChanged: (value) {
          setState(() {
            widget.todo.isCompleted = value!;
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
