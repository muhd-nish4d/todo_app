import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/constants/fonts/font_decerations.dart';
import 'package:todoapp/screens/add_edit/add_edit.dart';
import 'package:todoapp/screens/detail/todo_detail.dart';

class ScreenTodos extends StatelessWidget {
  const ScreenTodos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todos', style: textHeadings),
          // centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
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
                    backgroundColor: const Color(0xFFFE4A49).withOpacity(.0),
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
                          builder: (context) =>
                              const ScreenCostamize(isEdit: true)));
                    },
                    backgroundColor: const Color(0xFF7BC043).withOpacity(.0),
                    foregroundColor: Colors.blue,
                    icon: Icons.edit,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ScreenTodoDetail(),
                  ));
                },
                child: Card(
                  color: Colors.white12,
                  child: ListTile(
                    leading: Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ),
                    title: const Text('Title', style: textHeadings),
                    subtitle:
                        const Text('Description...', style: textDescriptions),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: ElevatedButton.icon(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.purple[900]),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScreenCostamize(isEdit: false),
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
