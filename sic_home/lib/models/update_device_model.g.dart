// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDeviceModel _$UpdateDeviceModelFromJson(Map<String, dynamic> json) =>
    UpdateDeviceModel(
      name: json['name'] as String,
      deviceType: $enumDecode(_$DeviceTypeEnumMap, json['deviceType']),
      placeId: (json['placeId'] as num).toInt(),
      sectionId: (json['sectionId'] as num).toInt(),
      pin: (json['pin'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateDeviceModelToJson(UpdateDeviceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deviceType': _$DeviceTypeEnumMap[instance.deviceType]!,
      'placeId': instance.placeId,
      'sectionId': instance.sectionId,
      'pin': instance.pin,
    };

const _$DeviceTypeEnumMap = {
  DeviceType.onoff: 0,
  DeviceType.analog: 1,
};
