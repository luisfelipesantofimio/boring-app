import 'dart:math';

import 'package:boring_app/main.dart';
import 'package:boring_app/src/api/bored_api.dart';
import 'package:boring_app/src/database/todos.dart';
import 'package:boring_app/src/model/response_model.dart';
import 'package:boring_app/src/providers/bored_data_provider.dart';
import 'package:boring_app/src/providers/colors_provider.dart';
import 'package:boring_app/src/views/bottom_todo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    Future(
      () async {
        final newData = Todos()
          ..date = DateTime.now()
          ..done = false
          ..title = "aaa";

        await isar.writeTxn(() async {
          await isar.todos.put(newData); // perform update operations

          await isar.todos.delete(newData.id); // or delete operations
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final boringData = ref.watch(boringDataProvider);
    final localStreamTodos = ref.watch(localStreamProvider);

    return Scaffold(
      backgroundColor: getRandomColor(),
      body: InkWell(
        onTap: () {
          ref.invalidate(boringDataProvider);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: boringData.when(
                data: (data) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          data.activity,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(
                            10,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "People needed: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(data.participants > 1
                                ? Icons.group
                                : Icons.person),
                            const Padding(
                              padding: EdgeInsets.all(2),
                            ),
                            Text(data.participants.toString()),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(
                            8,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Challenge: "),
                            const Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: TweenAnimationBuilder<double>(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeIn,
                                tween: Tween<double>(
                                  begin: 0,
                                  end: data.accessibility,
                                ),
                                builder: (context, value, _) =>
                                    LinearProgressIndicator(
                                  minHeight: 10,
                                  value: value,
                                  backgroundColor: Colors.grey,
                                  color: challengeColor(data.accessibility),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(
                            20,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: Color.fromARGB(255, 213, 213, 213),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextButton(
                              onPressed: () async {
                                List<String> currentTitles = [];
                                for (Todos element
                                    in localStreamTodos.value ?? []) {
                                  currentTitles.add(element.title ?? "");
                                }
                                if (currentTitles.contains(data.activity)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "The task already exists.",
                                      ),
                                    ),
                                  );
                                } else {
                                  Todos newTodo = Todos()
                                    ..title = data.activity
                                    ..done = false
                                    ..accessibility = data.accessibility
                                    ..participants = data.participants
                                    ..date = DateTime.now();
                                  await isar.writeTxn(
                                    () => isar.todos.put(newTodo),
                                  );
                                  Future(
                                    () => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          "Task added!",
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "Sounds fun!",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  shape: Border.all(style: BorderStyle.solid),
                                  backgroundColor: getRandomColor(),
                                  context: context,
                                  builder: (context) => localStreamTodos.when(
                                    data: (data1) => Visibility(
                                      visible: data1.isNotEmpty,
                                      child: TodosList(todosList: data1),
                                    ),
                                    error: (error, stackTrace) =>
                                        const Text("Something went wrong :("),
                                    loading: () => const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator()),
                                  ),
                                );
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.task_alt,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Text(
                                    "My tasks",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) =>
                    Text("Algo salió mal :(\n $error"),
                loading: () => const CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
