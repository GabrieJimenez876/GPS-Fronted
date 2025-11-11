import 'package:latlong2/latlong.dart';

class StopModel {
  final String id;
  final String name;
  final LatLng location;
  final List<String> routeIds;
  final String? description;
  final String? address;

  StopModel({
    required this.id,
    required this.name,
    required this.location,
    required this.routeIds,
    this.description,
    this.address,
  });

  factory StopModel.fromJson(Map<String, dynamic> json) {
    return StopModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: LatLng(
        json['location']['lat'] as double,
        json['location']['lng'] as double,
      ),
      routeIds: List<String>.from(json['routeIds'] as List),
      description: json['description'] as String?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': {'lat': location.latitude, 'lng': location.longitude},
      'routeIds': routeIds,
      'description': description,
      'address': address,
    };
  }
}
