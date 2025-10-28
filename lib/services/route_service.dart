import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../constants.dart';
import '../models/route_model.dart';

class RouteService {
  static final RouteService _instance = RouteService._internal();

  factory RouteService() {
    return _instance;
  }

  RouteService._internal();

  /// Obtiene todas las rutas del servidor
  Future<List<RouteModel>> fetchRoutes() async {
    final response = await http.get(
      Uri.parse('$BASE_URL/routes/all'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => RouteModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener las rutas: ${response.statusCode}');
    }
  }

  /// Convierte una geometría GeoJSON en una lista de coordenadas LatLng
  List<LatLng> parseGeoJson(String geojsonGeometry) {
    try {
      final Map<String, dynamic> geometry = jsonDecode(geojsonGeometry);

      if (geometry['type'] != 'LineString') {
        throw Exception('Tipo de geometría no soportado: ${geometry['type']}');
      }

      final List<dynamic> coordinates = geometry['coordinates'];
      return coordinates.map((coord) {
        // GeoJSON usa [longitud, latitud]
        return LatLng(coord[1].toDouble(), coord[0].toDouble());
      }).toList();
    } catch (e) {
      throw Exception('Error al parsear GeoJSON: $e');
    }
  }
}
