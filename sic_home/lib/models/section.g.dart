// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) => Section(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      userId: json['userId'] as String,
      placeId: (json['placeId'] as num).toInt(),
      devices: (json['devices'] as List<dynamic>)
          .map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'placeId': instance.placeId,
      'devices': instance.devices,
    };
