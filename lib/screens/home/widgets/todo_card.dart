import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/constants/fonts/font_decerations.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'package:todoapp/screens/add_edit/add_edit.dart';
import 'package:todoapp/screens/detail/todo_detail.dart';

import '../../../model/todo_model.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.eachTodo,
  });

  final TodoModel eachTodo;

  @override
  Widget build(BuildContext context) {
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
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ScreenCostamize(
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
              title: Text(eachTodo.title,
                  style: eachTodo.isCompleted
                      ? textHeadingsCompletd
                      : textHeadingsUncompletd),
              subtitle: Text(eachTodo.description,
                  style: textDescriptions),
            ),
          ),
        ),
      );
  }
}