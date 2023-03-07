import 'dart:convert';
import 'package:boring_app/src/model/response_model.dart';
import 'package:http/http.dart' as http;

Future<http.Response> boredApiGet() async {
  Uri url = Uri.parse("https://www.boredapi.com/api/activity");
  final response = await http.get(url);
  return response;
}

ResponseModel decodeApiData(http.Response apiResponse) {
  final data = jsonDecode(apiResponse.body);
  ResponseModel decodedInformation = ResponseModel.fromJson(data);
  return decodedInformation;
}
