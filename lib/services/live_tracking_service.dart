import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/vehicle_location_model.dart';
import '../constants.dart';

class LiveTrackingService {
  WebSocketChannel? _channel;
  StreamController<List<VehicleLocationModel>>? _locationController;
  bool _isConnected = false;

  static final LiveTrackingService _instance = LiveTrackingService._internal();

  factory LiveTrackingService() {
    return _instance;
  }

  LiveTrackingService._internal();

  bool get isConnected => _isConnected;

  /// Conecta al WebSocket y devuelve un Stream de ubicaciones de vehículos
  Stream<List<VehicleLocationModel>> connectAndStream() {
    if (_locationController?.isClosed ?? true) {
      _locationController =
          StreamController<List<VehicleLocationModel>>.broadcast();
    }

    if (!_isConnected) {
      _connect();
    }

    return _locationController!.stream;
  }

  void _connect() {
    try {
      // Crear conexión WebSocket
      final wsUrl = Uri.parse('ws://localhost:4001/ws/live');
      _channel = WebSocketChannel.connect(wsUrl);
      _isConnected = true;

      // Escuchar mensajes del WebSocket
      _channel!.stream.listen(
        (dynamic message) {
          try {
            final List<dynamic> jsonData = jsonDecode(message as String);
            final locations = jsonData
                .map((json) => VehicleLocationModel.fromJson(json))
                .toList();
            _locationController?.add(locations);
          } catch (e) {
            print('Error al procesar mensaje del WebSocket: $e');
          }
        },
        onError: (error) {
          print('Error en WebSocket: $error');
          _handleDisconnection();
        },
        onDone: () {
          print('Conexión WebSocket cerrada');
          _handleDisconnection();
        },
      );
    } catch (e) {
      print('Error al conectar WebSocket: $e');
      _handleDisconnection();
    }
  }

  void _handleDisconnection() {
    _isConnected = false;
    _channel?.sink.close();
    // Intentar reconectar después de un delay
    Future.delayed(const Duration(seconds: 5), () {
      if (!_isConnected && !(_locationController?.isClosed ?? true)) {
        _connect();
      }
    });
  }

  /// Cierra la conexión y libera recursos
  void dispose() {
    _isConnected = false;
    _channel?.sink.close();
    _locationController?.close();
  }
}
