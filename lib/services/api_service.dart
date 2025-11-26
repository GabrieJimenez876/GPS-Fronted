import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<dynamic>> getLineas() async {
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
