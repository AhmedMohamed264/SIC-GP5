// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDeviceModel _$CreateDeviceModelFromJson(Map<String, dynamic> json) =>
    CreateDeviceModel(
      name: json['name'] as String,
      dataType: $enumDecode(_$DeviceDataTypeEnumMap, json['dataType']),
      userId: json['userId'] as String,
      placeId: (json['placeId'] as num).toInt(),
      sectionId: (json['sectionId'] as num).toInt(),
      pin: (json['pin'] as num).toInt(),
    );

Map<String, dynamic> _$CreateDeviceModelToJson(CreateDeviceModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dataType': _$DeviceDataTypeEnumMap[instance.dataType]!,
      'userId': instance.userId,
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
