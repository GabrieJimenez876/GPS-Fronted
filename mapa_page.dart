import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http; // Para cargar JSON desde web

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  LatLng ubicacionActual = const LatLng(-16.5, -68.15);
  List<Marker> marcadores = [];
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    obtenerUbicacion();
    cargarMarcadoresDesdeJSON();
  }

  Future<void> obtenerUbicacion() async {
    bool servicio = await Geolocator.isLocationServiceEnabled();
    if (!servicio) return;

    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.deniedForever) return;
    }

    try {
      Position posicion = await Geolocator.getCurrentPosition();
      setState(() {
        ubicacionActual = LatLng(posicion.latitude, posicion.longitude);
        marcadores.add(Marker(
          point: ubicacionActual,
          child: const Icon(Icons.location_on, color: Colors.blue),
        ));
      });
    } catch (e) {
      debugPrint('Error obteniendo ubicación: $e');
    }
  }

  Future<void> cargarMarcadoresDesdeJSON() async {
    try {
      final response = await http.get(Uri.parse('punt.json')); // Carga desde web
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          marcadores.addAll(data.map<Marker>((punto) => Marker(
            point: LatLng(punto['lat'], punto['lng']),
            child: const Icon(Icons.place, color: Colors.red),
          )).toList());
        });
      }
    } catch (e) {
      debugPrint('Error cargando JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa - GPS Transporte')),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: ubicacionActual,
          initialZoom: 13.0,
          // cameraConstraint can be added here when migrating fully to flutter_map v6
          // e.g. cameraConstraint: CameraConstraint(...)
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(markers: marcadores),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/agregar_linea'),
            child: const Icon(Icons.add),
            tooltip: 'Agregar Línea',
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: obtenerUbicacion,
            child: const Icon(Icons.my_location),
            tooltip: 'Mi Ubicación',
          ),
        ],
      ),
    );
  }
}
