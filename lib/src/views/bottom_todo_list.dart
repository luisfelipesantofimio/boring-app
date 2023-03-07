import 'dart:developer';

import 'package:boring_app/main.dart';
import 'package:boring_app/src/database/todos.dart';
import 'package:boring_app/src/providers/bored_data_provider.dart';
import 'package:boring_app/src/views/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TodosList extends ConsumerStatefulWidget {
  const TodosList({super.key, required this.todosList});

  final List<Todos> todosList;

  @override
  TodosListState createState() => TodosListState();
}

class TodosListState extends ConsumerState<TodosList> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      minChildSize: 0.1,
      expand: true,
      builder: (context, scrollController) {
        return ListView.builder(
          controller: scrollController,
          itemCount: widget.todosList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 8,
                  bottom: 8,
                ),
                child: ListItem(
                  todoItem: widget.todosList[index],
                ));
          },
        );
      },
    );
  }
}
