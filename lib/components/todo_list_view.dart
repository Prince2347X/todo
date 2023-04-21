import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo/components/todo.dart';
import 'package:todo/objects/todo.dart';

class TodoListView extends StatefulWidget {
  final bool isCompleted;
  const TodoListView({super.key, required this.isCompleted});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  User user = FirebaseAuth.instance.currentUser!;

  Stream<List<TodoObject>> _todoStream() {
    return FirebaseFirestore.instance
        .collection('todos')
        .orderBy('createdAt', descending: true)
        .where('userId', isEqualTo: user.uid)
        .where('isCompleted', isEqualTo: widget.isCompleted)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => TodoObject.fromJson(doc.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<TodoObject>>(
        stream: _todoStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final todos = snapshot.data!;
            print(todos);
            return ListView(
              children: todos.map((TodoObject todo){
                return TodoTile(todo: todo);
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong.\n${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
