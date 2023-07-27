import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/fonts/font_decerations.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'package:todoapp/utils/utils.dart';

class ScreenCostamize extends StatelessWidget {
  ScreenCostamize({super.key, required this.isEdit, this.oldTodo});
  final bool isEdit;
  final TodoModel? oldTodo;
  TextEditingController titleController = TextEditingController();
  TextEditingController descritpionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController =
        TextEditingController(text: oldTodo != null ? oldTodo!.title : null);
    descritpionController = TextEditingController(
        text: oldTodo != null ? oldTodo!.description : null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
        title: Text(
          isEdit ? 'Edit' : 'Add',
          style: textHeadingsUncompletd,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: 'Title', hintStyle: textDescriptions),
            ),
            const SizedBox(height: 50),
            TextFormField(
              controller: descritpionController,
              style: const TextStyle(color: Colors.white),
              maxLines: 10,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description...',
                  hintStyle: textDescriptions),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          TodoModel todo = TodoModel(
              userId: Utils.currentUser!.uid,
              title: titleController.text,
              description: descritpionController.text,
              isCompleted: false,
              date: DateTime.now().toString());
          isEdit
              ? Provider.of<TodoListProvider>(context, listen: false)
                  .editTodu(oldTodo!, todo, context)
              : Provider.of<TodoListProvider>(context, listen: false)
                  .addNewTodoList(todo, context);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
