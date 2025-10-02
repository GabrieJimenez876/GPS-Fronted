import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  LatLng ubicacionActual = LatLng(-16.5, -68.15); // Centro de La Paz

  @override
  void initState() {
    super.initState();
    obtenerUbicacion();
  }

  Future<void> obtenerUbicacion() async {
    bool servicio = await Geolocator.isLocationServiceEnabled();
    if (!servicio) return;

    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.deniedForever) return;
    }

    Position posicion = await Geolocator.getCurrentPosition();
    setState(() {
      ubicacionActual = LatLng(posicion.latitude, posicion.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mapa de Transporte La Paz')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: FlutterMap(
              options: MapOptions(
                center: ubicacionActual,
                zoom: 14.0,
                maxBounds: LatLngBounds(
                  LatLng(-16.55, -68.25),
                  LatLng(-16.45, -68.05),
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.transporte_la_paz',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: ubicacionActual,
                      builder: (ctx) => Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
                    ),
                    Marker(
                      point: LatLng(-16.495, -68.133), // Ejemplo parada
                      builder: (ctx) => Icon(Icons.bus_alert, color: Colors.red, size: 30),
                    ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [
                        LatLng(-16.495, -68.133),
                        LatLng(-16.49, -68.13),
                        LatLng(-16.485, -68.125),
                      ],
                      strokeWidth: 4.0,
                      color: Colors.yellow,
                    ),
                    Polyline(
                      points: [
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
              padding: EdgeInsets.all(8),
              children: [
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