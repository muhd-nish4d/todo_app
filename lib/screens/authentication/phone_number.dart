import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/home/todos.dart';

class ScreenPhoneNumber extends StatelessWidget {
  ScreenPhoneNumber({super.key});
  final TextEditingController phoneNumberController =
      TextEditingController(text: '+91');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              // decoration: ,
              // height: 60,
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: phoneNumberController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Send OTP')),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signInAnonymously().then((user) {
                    log('User logged in anonymously');
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ScreenTodos(),
                    ));
                  }).catchError((error) {
                    log('Error logging in anonymously: $error');
                  });
                  final currentUser = FirebaseAuth.instance.currentUser;
                  log(currentUser.toString());
                },
                child: const Text('As Guest'))
          ],
        ),
      ),
    );
  }
}
