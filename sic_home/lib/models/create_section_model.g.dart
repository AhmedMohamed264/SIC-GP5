// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSectionModel _$CreateSectionModelFromJson(Map<String, dynamic> json) =>
    CreateSectionModel(
      name: json['name'] as String,
      userId: json['userId'] as String,
      placeId: (json['placeId'] as num).toInt(),
    );

Map<String, dynamic> _$CreateSectionModelToJson(CreateSectionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'userId': instance.userId,
      'placeId': instance.placeId,
    };
