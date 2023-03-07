import 'package:boring_app/src/database/todos.dart';
import 'package:boring_app/src/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

late Isar isar;
void main() async {
  isar = await Isar.open([TodosSchema]);
  runApp(
    const ProviderScope(
      child: BoringApp(),
    ),
  );
}

class BoringApp extends StatelessWidget {
  const BoringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}
