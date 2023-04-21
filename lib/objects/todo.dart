import 'package:cloud_firestore/cloud_firestore.dart';

class TodoObject {
  DateTime createdAt;
  String id;
  bool isCompleted;
  DateTime modifiedAt;
  List<String>? subtasks;
  String title;
  String userId;

  TodoObject({
    required this.createdAt,
    required this.id,
    required this.isCompleted,
    required this.modifiedAt,
    this.subtasks,
    required this.title,
    required this.userId,
  });

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
