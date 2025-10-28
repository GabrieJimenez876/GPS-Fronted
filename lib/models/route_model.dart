import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'route_model.g.dart';

@JsonSerializable()
class RouteModel {
  final int id;
  final String name;
  final String colorHex;
  final String geojsonGeometry;

  RouteModel({
    required this.id,
    required this.name,
    required this.colorHex,
    required this.geojsonGeometry,
  });

  // Métodos factory para serialización JSON
  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);
  Map<String, dynamic> toJson() => _$RouteModelToJson(this);
}
