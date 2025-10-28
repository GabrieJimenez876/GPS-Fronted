import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../models/route_model.dart';

class StopsViewModel {
  final List<LatLng> _stops = [];
  static const double MAX_DISTANCE = 500; // metros

  Future<void> loadStops(List<RouteModel> routes) async {
    // TODO: Implementar carga de paradas desde el servicio
    // Por ahora usamos datos de ejemplo
    _stops.clear();
    _stops.addAll([
      LatLng(-17.3934, -66.1568), // Plaza Principal
      LatLng(-17.3915, -66.1555), // Parada 1
      LatLng(-17.3950, -66.1580), // Parada 2
      // Añadir más paradas según necesites
    ]);
  }

  List<LatLng> getNearbyStops(LatLng userLocation) {
    return _stops.where((stop) {
      final distanceInMeters = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        stop.latitude,
        stop.longitude,
      );
      return distanceInMeters <= MAX_DISTANCE;
    }).toList();
  }
}
