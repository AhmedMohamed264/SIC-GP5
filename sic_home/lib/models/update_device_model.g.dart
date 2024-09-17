// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDeviceModel _$UpdateDeviceModelFromJson(Map<String, dynamic> json) =>
    UpdateDeviceModel(
      name: json['name'] as String,
      dataType: $enumDecode(_$DeviceDataTypeEnumMap, json['dataType']),
      placeId: (json['placeId'] as num).toInt(),
      sectionId: (json['sectionId'] as num).toInt(),
      pin: (json['pin'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateDeviceModelToJson(UpdateDeviceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dataType': _$DeviceDataTypeEnumMap[instance.dataType]!,
      'placeId': instance.placeId,
      'sectionId': instance.sectionId,
      'pin': instance.pin,
    };

const _$DeviceDataTypeEnumMap = {
  DeviceDataType.integer: 0,
  DeviceDataType.float: 1,
  DeviceDataType.string: 2,
  DeviceDataType.boolean: 3,
};
