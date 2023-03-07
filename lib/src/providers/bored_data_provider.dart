import 'dart:convert';
import 'dart:developer';

import 'package:boring_app/main.dart';
import 'package:boring_app/src/api/bored_api.dart';
import 'package:boring_app/src/database/todos.dart';
import 'package:boring_app/src/model/response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final boringDataProvider = FutureProvider<ResponseModel>((ref) async {
  final response = await boredApiGet();

  final data = jsonDecode(response.body);
  log(data.toString());
  ResponseModel finalData = ResponseModel.fromJson(data);

  return finalData;
});

final localStreamProvider = StreamProvider<List<Todos>>(
  (ref) {
    Query<Todos> query = isar.todos.buildQuery();
    return query.watch();
  },
);
