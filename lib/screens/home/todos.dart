import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/fonts/font_decerations.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'package:todoapp/screens/add_edit/add_edit.dart';
import 'package:todoapp/screens/home/widgets/todo_card.dart';
import 'package:todoapp/utils/utils.dart';

class ScreenTodos extends StatelessWidget {
  ScreenTodos({super.key});

  final ValueNotifier<bool> isCompleted = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    // log(todoDetails.length.toString());
    log(Utils.currentUser!.uid);
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.grey[900],
          child: Consumer<TodoListProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.black,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DrawerTodoStatus(
                              color: Colors.green,
                              count: value.todoListCompleted.length.toString(),
                              label: 'Completed'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DrawerTodoStatus(
                                  color: Colors.red,
                                  count:
                                      value.todoListpending.length.toString(),
                                  label: 'Pending'),
                              DrawerTodoStatus(
                                  color: Colors.white,
                                  count: value.todoList.length.toString(),
                                  label: 'Total'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Provider.of<TodoListProvider>(context, listen: false)
                          .userSignOut(context);
                    },
                    title: const Text(
                      'LogOut',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Todos', style: textHeadingsUncompletd),
          // centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Consumer<TodoListProvider>(
          builder: (context, value, child) {
            return value.todoList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemBuilder: (context, index) {
                      final eachTodo = value.todoList[index];
                      return eachTodo.isCompleted
                          ? const SizedBox()
                          : TodoCard(eachTodo: eachTodo);
                    },
                    itemCount: value.todoList.length,
                  );
          },
        ),
        floatingActionButton: ElevatedButton.icon(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.purple[900]),
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScreenCostamize(isEdit: false),
              ));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: const Text(
              'Add Todo',
              style: TextStyle(color: Colors.white),
            )));
  }
}

class DrawerTodoStatus extends StatelessWidget {
  const DrawerTodoStatus({
    super.key,
    required this.count,
    required this.label,
    required this.color,
  });
  final String count;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
              color: color, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
