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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 60.0,
            bottom: 12,
          ),
          child: Text(
            !widget.isCompleted ? 'ACTIVE TODOS' : 'COMPLETED TODOS',
            style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<TodoObject>>(
            stream: _todoStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final todos = snapshot.data!;
                return ListView(
                  children: todos.map((TodoObject todo) {
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
        ),
      ],
    );
  }
}
