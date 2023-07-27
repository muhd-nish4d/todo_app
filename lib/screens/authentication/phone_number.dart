import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/fonts/font_decerations.dart';
import 'package:todoapp/provider/login_provider.dart';
import 'package:todoapp/screens/home/todos.dart';

class ScreenPhoneNumber extends StatelessWidget {
  ScreenPhoneNumber({super.key});
  final TextEditingController phoneNumberController =
      TextEditingController(text: '+91');
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              // decoration: ,
              // height: 60,
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: 'Name',
                      hintStyle: textDescriptions,
                      border: InputBorder.none),
                ),
              ),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<LoginProvider>(
                  builder: (context, value, child) => value.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            value.submittedPhoneNumber(
                                phoneNumberController.text, context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            'Send OTP',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ),
                TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signInAnonymously().then((user) {
                        log('User logged in anonymously');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ScreenTodos(),
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
          ],
        ),
      ),
    );
  }
}
