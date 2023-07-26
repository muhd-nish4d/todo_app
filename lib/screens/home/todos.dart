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
  const ScreenTodos({super.key});

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
                            log('hi');
                          }),
                          children: [
                            SlidableAction(
                              onPressed: (context) {},
                              backgroundColor:
                                  const Color(0xFFFE4A49).withOpacity(.0),
                              foregroundColor: Colors.red,
                              icon: Icons.delete,
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              flex: 2,
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
                              leading: Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                              title: Text(eachTodo.title, style: textHeadings),
                              subtitle: Text(eachTodo.description,
                                  style: textDescriptions),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: value.todoList.length,
                  );
          },
        ),
        // FutureBuilder(
        //   future: Utils.getCurrentUserTodos(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //         padding: const EdgeInsets.all(10),
        //         itemBuilder: (context, index) {
        //           final eachTodo = snapshot.data![index];
        //           return Slidable(
        //             key: UniqueKey(),
        //             startActionPane: ActionPane(
        //               motion: const ScrollMotion(),
        //               dismissible: DismissiblePane(onDismissed: () {
        //                 log('hi');
        //               }),
        //               children: [
        //                 SlidableAction(
        //                   onPressed: (context) {},
        //                   backgroundColor:
        //                       const Color(0xFFFE4A49).withOpacity(.0),
        //                   foregroundColor: Colors.red,
        //                   icon: Icons.delete,
        //                 ),
        //               ],
        //             ),
        //             endActionPane: ActionPane(
        //               motion: const ScrollMotion(),
        //               children: [
        //                 SlidableAction(
        //                   flex: 2,
        //                   onPressed: (context) {
        //                     Navigator.of(context).push(MaterialPageRoute(
        //                         builder: (context) =>
        //                             ScreenCostamize(isEdit: true)));
        //                   },
        //                   backgroundColor:
        //                       const Color(0xFF7BC043).withOpacity(.0),
        //                   foregroundColor: Colors.blue,
        //                   icon: Icons.edit,
        //                 ),
        //               ],
        //             ),
        //             child: InkWell(
        //               onTap: () {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (context) =>
        //                       ScreenTodoDetail(todoDetail: eachTodo),
        //                 ));
        //               },
        //               child: Card(
        //                 color: Colors.white12,
        //                 child: ListTile(
        //                   leading: Checkbox(
        //                     value: false,
        //                     onChanged: (value) {},
        //                   ),
        //                   title: Text(eachTodo.title, style: textHeadings),
        //                   subtitle: Text(eachTodo.description,
        //                       style: textDescriptions),
        //                 ),
        //               ),
        //             ),
        //           );
        //         },
        //         itemCount: snapshot.data!.length,
        //       );
        //     } else {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
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
