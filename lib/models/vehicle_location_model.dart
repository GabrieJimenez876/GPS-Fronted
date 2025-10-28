import 'package:json_annotation/json_annotation.dart';

part 'vehicle_location_model.g.dart';

@JsonSerializable()
class VehicleLocationModel {
  final String vehicleId;
  final double latitude;
  final double longitude;

  VehicleLocationModel({
    required this.vehicleId,
    required this.latitude,
    required this.longitude,
  });

  // Métodos factory para serialización JSON
  factory VehicleLocationModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleLocationModelToJson(this);
}
