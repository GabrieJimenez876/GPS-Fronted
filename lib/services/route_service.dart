import 'dart:convert';
import 'package:http/http.dart' as http;

class RouteService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<dynamic>> getRoutes() async {
    final res = await http.get(Uri.parse('$baseUrl/api/lineas'));
    if (res.statusCode == 200) {
      return List<dynamic>.from(json.decode(res.body));
    }
    return [];
  }
}
