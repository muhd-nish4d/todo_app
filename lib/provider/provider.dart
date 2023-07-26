import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/model/todo_model.dart';

class TodoListProvider extends ChangeNotifier {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  List<TodoModel> todoList = [];

  Future<void> getCurrentUserTodos() async {
    try {
      final collectionRef = await firestore
          .collection('users')
          .doc(currentUser?.uid)
          .collection('todos')
          .orderBy('date', descending: true)
          .get();
      for (final document in collectionRef.docs) {
        var todo = TodoModel.fromJson(document.data());
        todoList.add(todo);
      }
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void addNewTodoList(TodoModel newTodo, BuildContext context) {
    final todoMap = newTodo.toMap();
    firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('todos')
        .add(todoMap)
        .then((value) {
      log('added  $value');
      todoList.clear();
      getCurrentUserTodos();
      Navigator.of(context).pop();
    }).catchError((e) {
      log(e.toString());
    });
  }

  void editTodu(
      TodoModel previousTodo, TodoModel newTodo, BuildContext context) async {
    try {
      final querySnapshot = await firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('todos')
          .where('title', isEqualTo: previousTodo.title)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final documentRef = querySnapshot.docs.first.reference;
        final updatedTodo = newTodo.toMap();

        documentRef.update(updatedTodo);
        log('Todo field updated successfully.');

        todoList.clear();
        getCurrentUserTodos().then((value) {
          Navigator.pop(context);
        });
      } else {
        log('No todo found with the given title.');
      }
    } catch (e) {
      log('Error updating todo field: $e');
    }
  }
}
