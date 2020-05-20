import 'dart:convert';

import 'package:ArcadeArtBox/players.dart';
import 'package:http/http.dart' as http;

Future<Players> fetchPlayers() async {
  final response = await http.get('http://10.0.0.216:8000/api/players/');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Players.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load players');
  }
}