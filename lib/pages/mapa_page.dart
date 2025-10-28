import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../models/route_model.dart';
import '../models/vehicle_location_model.dart';
import '../models/stop_model.dart';
import '../models/syndicate_model.dart';
import '../services/route_service.dart';
import '../services/live_tracking_service.dart';
import '../services/stop_service.dart';
import '../services/syndicate_service.dart';
import '../viewmodels/stops_viewmodel.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final RouteService _routeService = RouteService();
  final LiveTrackingService _trackingService = LiveTrackingService();
  final StopsViewModel _stopsViewModel = StopsViewModel();
  final StopService _stopService = StopService();
  final SyndicateService _syndicateService = SyndicateService();

  // Coordenadas de La Paz (Centro)
  final LatLng laPazCenter = const LatLng(-16.5000, -68.1500);

  StreamSubscription<Position>? _positionStream;
  LatLng? _currentUserLocation;
  LatLng? _selectedDestination;

  // Estado para el panel de información
  RouteModel? _selectedRoute;
  bool _showInfoPanel = false;
  List<SyndicateModel>? _currentSyndicates;
  List<StopModel>? _routeStops;

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _setupLocationTracking();
  }

  Future<void> _setupLocationTracking() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    _positionStream = Geolocator.getPositionStream().listen((
      Position position,
    ) {
      setState(() {
        _currentUserLocation = LatLng(position.latitude, position.longitude);
      });
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    _trackingService.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Polyline> _buildRoutePolylines(List<RouteModel> routes) {
    return routes.map((route) {
      final coordinates = _routeService.parseGeoJson(route.geojsonGeometry);
      return Polyline(
        points: coordinates,
        color: Color(int.parse(route.colorHex.replaceAll('#', '0xFF'))),
        strokeWidth: 4.0,
      );
    }).toList();
  }

  void _onRouteTap(RouteModel route) {
    setState(() {
      _selectedRoute = route;
      _showInfoPanel = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
              initialCenter: laPazCenter,
              initialZoom: 13.0,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
              onTap: (_, point) => setState(() {
                _selectedDestination = point;
              }),
            ),
            children: [
              // Capa base de OpenStreetMap
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),

              // Capa de rutas estáticas
              FutureBuilder<List<RouteModel>>(
                future: _routeService.fetchRoutes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _stopsViewModel.loadStops(snapshot.data!);
                    return PolylineLayer(
                      polylines: _buildRoutePolylines(snapshot.data!),
                    );
                  }
                  return const PolylineLayer(polylines: []);
                },
              ),

              // Capa de vehículos en tiempo real
              StreamBuilder<List<VehicleLocationModel>>(
                stream: _trackingService.connectAndStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MarkerLayer(
                      markers: snapshot.data!
                          .map(
                            (vehicle) => Marker(
                              point: LatLng(
                                vehicle.latitude,
                                vehicle.longitude,
                              ),
                              child: Icon(
                                Icons.directions_bus,
                                color: Colors.blue[700],
                                size: 30,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }
                  return const MarkerLayer(markers: []);
                },
              ),

              // Capa de ubicación del usuario y destino
              MarkerLayer(
                markers: [
                  if (_currentUserLocation != null)
                    Marker(
                      point: _currentUserLocation!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  if (_selectedDestination != null)
                    Marker(
                      point: _selectedDestination!,
                      child: const Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 36,
                      ),
                    ),
                  ..._stopsViewModel
                      .getNearbyStops(_currentUserLocation!)
                      .map(
                        (stop) => Marker(
                          point: stop,
                          child: const Icon(
                            Icons.bus_alert,
                            color: Colors.green,
                            size: 24,
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ],
          ),
          // Barra de búsqueda
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar parada o ruta...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _isSearching
                      ? const CircularProgressIndicator()
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onChanged: (value) {
                  // Implementar búsqueda
                },
              ),
            ),
          ),

          if (_showInfoPanel && _selectedRoute != null)
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.1,
              maxChildSize: 0.5,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Barra de arrastre
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // Información de la ruta
                      Text(
                        _selectedRoute!.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              _selectedRoute!.colorHex.replaceAll('#', '0xFF'),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Línea Activa',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Recorrido',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('ID de Ruta: ${_selectedRoute!.id}'),

                      // Información del sindicato
                      if (_currentSyndicates != null &&
                          _currentSyndicates!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              'Sindicato',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ..._currentSyndicates!.map(
                              (syndicate) => Card(
                                child: ListTile(
                                  title: Text(syndicate.name),
                                  subtitle: Text(syndicate.description),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.phone),
                                    onPressed: () {
                                      // Implementar llamada
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      // Paradas de la ruta
                      if (_routeStops != null && _routeStops!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              'Paradas',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ..._routeStops!.map(
                              (stop) => Card(
                                child: ListTile(
                                  leading: const Icon(Icons.bus_alert),
                                  title: Text(stop.name),
                                  subtitle: Text(stop.address ?? ''),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_selectedDestination != null)
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _selectedDestination = null;
                });
              },
              backgroundColor: Colors.red,
              mini: true,
              child: const Icon(Icons.close),
            ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/agregar-linea');
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.add_road),
          ),
        ],
      ),
    );
  }
}
