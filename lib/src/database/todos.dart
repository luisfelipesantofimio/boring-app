import 'package:isar/isar.dart';

part "todos.g.dart";

@collection
class Todos {
  Id id = Isar.autoIncrement;
  String? title;
  int? participants;
  double? accessibility;
  DateTime? date;
  bool? done;
}
