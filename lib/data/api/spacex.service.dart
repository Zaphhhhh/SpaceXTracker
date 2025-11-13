import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/launch.model.dart';
import '../models/rocket.model.dart';

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

  static Future<Rocket> getRocketById(String rocketId) async {
    var url = Uri.https('api.spacexdata.com', '/v4/rockets/$rocketId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return Rocket.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load rocket data');
      }
    } catch (e) {
      throw Exception('Failed to load rocket: $e');
    }
  }
}
