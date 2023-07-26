import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/provider/provider.dart';
import 'package:todoapp/screens/authentication/phone_number.dart';
import 'package:todoapp/screens/home/todos.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    final User? user = FirebaseAuth.instance.currentUser;
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        if (user != null) {
          Provider.of<TodoListProvider>(context, listen: false)
              .getCurrentUserTodos();
          return ScreenTodos();
        } else {
          return ScreenPhoneNumber();
        }
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'splash',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
