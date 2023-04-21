import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:todo/services/firestore.dart';

class TodoObject {
  DateTime createdAt;
  String id;
  bool _isCompleted;
  DateTime modifiedAt;
  List<String>? subtasks;
  String title;
  String userId;

  TodoObject({
    required this.createdAt,
    required this.id,
    required isCompleted,
    required this.modifiedAt,
    this.subtasks,
    required this.title,
    required this.userId,
  }) : _isCompleted = isCompleted;

  get isCompleted => _isCompleted;

  set isCompleted(value) {
    _isCompleted = value;
    FirestoreServices.instance.updateTodo(this);
  }

  factory TodoObject.fromJson(Map<String, dynamic> json) {
    return TodoObject(
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      id: json['id'],
      isCompleted: json['isCompleted'],
      modifiedAt: (json['modifiedAt'] as Timestamp).toDate(),
      subtasks: json['subtasks'] != null ? List<String>.from(json['subtasks']) : null,
      title: json['title'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'id': id,
      'isCompleted': isCompleted,
      'modifiedAt': modifiedAt,
      'subtasks': subtasks,
      'title': title,
      'userId': userId,
    };
  }
}
