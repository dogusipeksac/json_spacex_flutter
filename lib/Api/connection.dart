
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex_flutter_app/model/spacex.dart';

Future<Spacex> apiCallSpacex() async {
  final response =
  await http.get('https://api.spacexdata.com/v4/launches/latest');
  if (response.statusCode == 200) {
    return Spacex.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load");
  }
}