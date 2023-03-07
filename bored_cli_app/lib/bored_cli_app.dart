import 'dart:io';

import 'package:bored_cli_app/api/bored_api.dart';
import 'package:bored_cli_app/utils/clean.dart';

import 'models/response_model.dart';

void boredAppInit() async {
  print("Are you bored?");

  ResponseModel data = decodeApiData(await boredApiGet());
  String? input = stdin.readLineSync();
  if (input == "y") {
    print("Idea: ${data.activity}");
    print("Press enter to continue...");
    stdin.readLineSync();
    cleanScreen();
    boredAppInit();
  } else if (input == "q") {
    cleanScreen();
    print("Bye. Have fun.");
  } else {
    print("Invalid comand.");
    print("Press enter to continue...");
    stdin.readLineSync();
    cleanScreen();
    boredAppInit();
  }
}
