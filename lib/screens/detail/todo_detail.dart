import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constants/fonts/font_decerations.dart';
import 'package:todoapp/model/todo_model.dart';

class ScreenTodoDetail extends StatelessWidget {
  const ScreenTodoDetail({super.key, required this.todoDetail});
  final TodoModel todoDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              todoDetail.title,
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Text(
            todoDetail.description,
            style: textDescriptions,
          ),
        ));
  }
}
