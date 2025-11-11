import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../models/stop_model.dart';
import '../constants.dart';

class StopService {
  final String baseUrl = BASE_URL;

  Future<List<StopModel>> fetchStops() async {
    final response = await http.get(Uri.parse('$baseUrl/api/stops'));

    if (response.statusCode == 200) {
      final List<dynamic> stopsJson = json.decode(response.body);
      return stopsJson.map((json) => StopModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stops');
    }
  }

  Future<List<StopModel>> getNearbyStops(
    LatLng location,
    double radiusKm,
  ) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/stops/nearby?lat=${location.latitude}&lng=${location.longitude}&radius=$radiusKm',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> stopsJson = json.decode(response.body);
      return stopsJson.map((json) => StopModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load nearby stops');
    }
  }

  Future<List<StopModel>> getStopsByRouteId(String routeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/stops/route/$routeId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> stopsJson = json.decode(response.body);
      return stopsJson.map((json) => StopModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stops for route');
    }
  }
}
