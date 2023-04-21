import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:todo/objects/todo.dart';

class FirestoreServices {
  static FirestoreServices? _instance;
  late final FirebaseFirestore _firestore;
  late final CollectionReference _todosCollection;

  FirestoreServices._internal() {
    _firestore = FirebaseFirestore.instance;
    _todosCollection = _firestore.collection('todos');
  }

  static FirestoreServices get instance {
    _instance ??= FirestoreServices._internal();
    return _instance!;
  }

  void createTodo(TodoObject todo) async {
    final newDocRef = _todosCollection.doc();
    final newDocData = todo.toJson();
    newDocData['id'] = newDocRef.id;
    await newDocRef.set(newDocData);
  }

  void updateTodo(TodoObject todo) async {
    Map<String, dynamic> updatedData = todo.toJson();
    updatedData['modifiedAt'] = DateTime.now();
    await _todosCollection.doc(todo.id).update(updatedData);
  }

  void deleteTodo(TodoObject todo) async {
    await _todosCollection.doc(todo.id).delete();
  }
}
