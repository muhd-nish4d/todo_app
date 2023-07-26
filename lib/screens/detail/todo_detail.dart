import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/fonts/font_decerations.dart';

class ScreenTodoDetail extends StatelessWidget {
  const ScreenTodoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Title',
              style: textHeadings,
            ),
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.chevron_back,
                color: Colors.white,
              ),
            )),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Text(
            'Description',
            style: textDescriptions,
          ),
        ));
  }
}
