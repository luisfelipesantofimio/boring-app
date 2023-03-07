import 'dart:developer';

import 'package:boring_app/main.dart';
import 'package:boring_app/src/database/todos.dart';
import 'package:boring_app/src/providers/colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key, required this.todoItem});
  final Todos todoItem;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    String formattedDate = formatter.format(
      widget.todoItem.date ?? DateTime.now(),
    );
    int itemAccesibility = widget.todoItem.participants ?? 0;
    double itemChallenge = widget.todoItem.accessibility ?? 0;
    return Container(
      height: 150,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 201, 237, 245),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          )),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    widget.todoItem.title ?? "No data",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: widget.todoItem.done ?? false
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
                Text(formattedDate),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Participants",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(itemAccesibility > 1
                                  ? Icons.group
                                  : Icons.person),
                              const Padding(
                                padding: EdgeInsets.all(3),
                              ),
                              Text(widget.todoItem.participants.toString())
                            ],
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(20)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Challenge",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: TweenAnimationBuilder<double>(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeIn,
                              tween: Tween<double>(
                                begin: 0,
                                end: itemChallenge,
                              ),
                              builder: (context, value, _) =>
                                  LinearProgressIndicator(
                                minHeight: 10,
                                value: value,
                                backgroundColor: Colors.grey,
                                color: challengeColor(itemChallenge),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await isar.writeTxn(() async {
                      widget.todoItem.done = !widget.todoItem.done!;

                      await isar.todos.put(widget.todoItem);
                    });
                    setState(() {});
                  },
                  icon: Icon(widget.todoItem.done ?? false
                      ? Icons.restart_alt
                      : Icons.done),
                ),
                IconButton(
                  onPressed: () async {
                    await isar.writeTxn(() async {
                      final success = await isar.todos.delete(
                        widget.todoItem.id,
                      );
                      log("Removed task with id: ${widget.todoItem.id} $success");
                    });
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
