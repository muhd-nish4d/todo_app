import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/fonts/font_decerations.dart';
import 'package:todoapp/provider/provider.dart';
import 'package:todoapp/screens/add_edit/add_edit.dart';
import 'package:todoapp/utils/utils.dart';

import '../detail/todo_detail.dart';

class ScreenTodos extends StatelessWidget {
  ScreenTodos({super.key});

  final ValueNotifier<bool> isCompleted = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    // log(todoDetails.length.toString());
    log(Utils.currentUser!.uid);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todos', style: textHeadings),
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
                      return Slidable(
                        key: UniqueKey(),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dismissible: DismissiblePane(onDismissed: () {
                            Provider.of<TodoListProvider>(context,
                                    listen: false)
                                .completeTodo(eachTodo);
                          }),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Provider.of<TodoListProvider>(context,
                                        listen: false)
                                    .completeTodo(eachTodo);
                              },
                              backgroundColor:
                                  const Color(0xFFFE4A49).withOpacity(.0),
                              foregroundColor: Colors.green,
                              label: 'Completed',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ScreenCostamize(
                                          isEdit: true,
                                          oldTodo: eachTodo,
                                        )));
                              },
                              backgroundColor:
                                  const Color(0xFF7BC043).withOpacity(.0),
                              foregroundColor: Colors.blue,
                              icon: Icons.edit,
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                Provider.of<TodoListProvider>(context,
                                        listen: false)
                                    .deleteTodo(eachTodo);
                              },
                              backgroundColor:
                                  const Color(0xFFFE4A49).withOpacity(.0),
                              foregroundColor: Colors.red,
                              icon: Icons.delete,
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ScreenTodoDetail(todoDetail: eachTodo),
                            ));
                          },
                          child: Card(
                            color: Colors.white12,
                            child: ListTile(
                              title: Text(eachTodo.title, style: textHeadings),
                              subtitle: Text(eachTodo.description,
                                  style: textDescriptions),
                              trailing: PopupMenuButton(
                                color: Colors.black,
                                itemBuilder: (context) => const [
                                  PopupMenuItem(child: Text('Edit')),
                                  PopupMenuItem(child: Text('Delete'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
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
