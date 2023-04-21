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
    return CheckboxListTile(
      title: Text(widget.todo.title),
      tileColor: Colors.white,
      value: widget.todo.isCompleted,
      onChanged: (value) {
        setState(() {
          widget.todo.isCompleted = value!;
        });
      },
    );
  }
}
