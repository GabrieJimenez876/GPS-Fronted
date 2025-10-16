import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  LatLng ubicacionActual = const LatLng(-16.5, -68.15);

  @override
  void initState() {
    super.initState();
    obtenerUbicacion();
  }

  Future<void> obtenerUbicacion() async {
    bool servicio = await Geolocator.isLocationServiceEnabled();
    // Si el servicio de geolocalización no está activado, no continuar
    if (!servicio) return;

    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.deniedForever) return;
    }

    // Obtener la posición actual y actualizar el estado para centrar el mapa
    Position posicion = await Geolocator.getCurrentPosition();
    setState(() {
      ubicacionActual = LatLng(posicion.latitude, posicion.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de Transporte La Paz')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: FlutterMap(
              // Configuración del mapa: centro inicial y restricciones de cámara
              options: MapOptions(
                initialCenter: ubicacionActual,
                initialZoom: 14.0,
                cameraConstraint: CameraConstraint.contain(bounds: LatLngBounds(
      const LatLng(-16.55, -68.25),
      const LatLng(-16.45, -68.05),
    ),
  ),
),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.transporte_la_paz',
                ),
                // Capa de marcadores: ubicación del usuario y paradas de ejemplo
                MarkerLayer(
                  markers: [
                    Marker(
                      point: ubicacionActual,
                      width: 40,
                      height: 40,
                      child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
                    ),
                    Marker(
                      point: const LatLng(-16.495, -68.133),
                      width: 30,
                      height: 30,
                      child: const Icon(Icons.bus_alert, color: Colors.red, size: 30),
                    ),
                  ],
                ),
                // Capas de polilíneas para mostrar recorridos de ejemplo
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: const [
                        LatLng(-16.495, -68.133),
                        LatLng(-16.49, -68.13),
                        LatLng(-16.485, -68.125),
                      ],
                      strokeWidth: 4.0,
                      color: Colors.yellow,
                    ),
                    Polyline(
                      points: const [
                        LatLng(-16.495, -68.133),
                        LatLng(-16.49, -68.135),
                        LatLng(-16.485, -68.14),
                      ],
                      strokeWidth: 4.0,
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: const [
                Text('Líneas cercanas:', style: TextStyle(fontWeight: FontWeight.bold)),
                Card(
                  child: ListTile(
                    title: Text('Línea Amarilla'),
                    subtitle: Text('Parada 10: Cementerio → Hospital Juan XXIII'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Línea Verde'),
                    subtitle: Text('Parada X: Cementerio → Munaypata'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
