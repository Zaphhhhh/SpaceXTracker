import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/launch.model.dart';

class SpaceXService {
  static Future<List<Launch>> getAll() async {
    var url = Uri.https('api.spacexdata.com', '/v4/launches');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Launch> launches = [];
        for (var launchJson in data) {
          try {
            launches.add(Launch.fromJson(launchJson));
          } catch (e) {
            print("L'objet a causé une erreur : $launchJson");
            print("L'erreur est : $e");
          }
        }
        return launches;

      } else {
        throw Exception('Failed to load launches from API');
      }
    } catch (e) {
      throw Exception('Failed to load launches: $e');
    }
  }
}