// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSectionModel _$UpdateSectionModelFromJson(Map<String, dynamic> json) =>
    UpdateSectionModel(
      name: json['name'] as String,
      placeId: (json['placeId'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateSectionModelToJson(UpdateSectionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'placeId': instance.placeId,
    };
