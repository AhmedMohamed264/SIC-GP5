// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDeviceModel _$CreateDeviceModelFromJson(Map<String, dynamic> json) =>
    CreateDeviceModel(
      name: json['name'] as String,
      deviceType: $enumDecode(_$DeviceTypeEnumMap, json['deviceType']),
      userId: json['userId'] as String,
      placeId: (json['placeId'] as num).toInt(),
      sectionId: (json['sectionId'] as num).toInt(),
    );

Map<String, dynamic> _$CreateDeviceModelToJson(CreateDeviceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deviceType': _$DeviceTypeEnumMap[instance.deviceType]!,
      'userId': instance.userId,
      'placeId': instance.placeId,
      'sectionId': instance.sectionId,
    };

const _$DeviceTypeEnumMap = {
  DeviceType.onoff: 0,
  DeviceType.analog: 1,
};
