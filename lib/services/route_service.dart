import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<dynamic>> getRoutes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/lineas'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}


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
