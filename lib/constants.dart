import 'dart:convert';
import 'package:http/http.dart' as http;

// Constantes para la configuración de la API
const String BASE_URL = 'http://localhost:4001';
const String LINES_SERVICE_URL = 'http://localhost:4002';
const String ROUTES_SERVICE_URL = 'http://localhost:4003';

/// Servicio para manejar la autenticación de usuarios
class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  /// Realiza el inicio de sesión del usuario
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error en el inicio de sesión: ${response.statusCode}');
    }
  }

  /// Registra un nuevo usuario en el sistema
  Future<Map<String, dynamic>> register(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error en el registro: ${response.statusCode}');
    }
  }
}
