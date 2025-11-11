// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleLocationModel _$VehicleLocationModelFromJson(
  Map<String, dynamic> json,
) => VehicleLocationModel(
  vehicleId: json['vehicleId'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$VehicleLocationModelToJson(
  VehicleLocationModel instance,
) => <String, dynamic>{
  'vehicleId': instance.vehicleId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
