import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/screens/authentication/phone_number.dart';

class TodoListProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  List<TodoModel> todoList = [];
  List<TodoModel> todoListCompleted = [];
  List<TodoModel> todoListpending = [];
  bool isLoading = false;

  Future<void> getCurrentUserTodos() async {
    try {
      final collectionRef = await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('todos')
          .orderBy('date', descending: true)
          .get();
      for (final document in collectionRef.docs) {
        var todo = TodoModel.fromJson(document.data());
        todoList.add(todo);
      }
      todoListCompleted =
          todoList.where((element) => element.isCompleted).toList();
      todoListpending =
          todoList.where((element) => element.isCompleted == false).toList();
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void addNewTodoList(TodoModel newTodo, BuildContext context) {
    final todoMap = newTodo.toMap();
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
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
          .doc(auth.currentUser!.uid)
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

  void deleteTodo(TodoModel todo) async {
    try {
      final querySnapshot = await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('todos')
          .where('title', isEqualTo: todo.title)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final documentRef = querySnapshot.docs.first.reference;

        documentRef.delete();
        log('Deleted');

        todoList.clear();
        getCurrentUserTodos();
      } else {
        log('No todo found with the given title.');
      }
    } catch (e) {
      log('Error updating todo field: $e');
    }
  }

  void completeTodo(TodoModel todo) async {
    try {
      final querySnapshot = await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('todos')
          .where('title', isEqualTo: todo.title)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final documentRef = querySnapshot.docs.first.reference;

        documentRef.update({'isCompleted': true});
        log('isCompleted updated');

        todoList.clear();
        getCurrentUserTodos();
      } else {
        log('No todo found with the given title.');
      }
    } catch (e) {
      log('Error updating todo field: $e');
    }
  }

  void userSignOut(BuildContext context) {
    auth.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ScreenPhoneNumber()),
          (route) => false);
    });
  }
}
