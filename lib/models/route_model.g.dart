// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => RouteModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  colorHex: json['colorHex'] as String,
  geojsonGeometry: json['geojsonGeometry'] as String,
);

Map<String, dynamic> _$RouteModelToJson(RouteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'colorHex': instance.colorHex,
      'geojsonGeometry': instance.geojsonGeometry,
    };
