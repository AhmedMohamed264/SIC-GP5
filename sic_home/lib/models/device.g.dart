// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      deviceType: $enumDecode(_$DeviceTypeEnumMap, json['deviceType']),
      userId: json['userId'] as String,
      placeId: (json['placeId'] as num).toInt(),
      sectionId: (json['sectionId'] as num).toInt(),
      pin: (json['pin'] as num).toInt(),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'deviceType': _$DeviceTypeEnumMap[instance.deviceType]!,
      'userId': instance.userId,
      'placeId': instance.placeId,
      'sectionId': instance.sectionId,
      'pin': instance.pin,
    };

const _$DeviceTypeEnumMap = {
  DeviceType.onoff: 0,
  DeviceType.analog: 1,
};
