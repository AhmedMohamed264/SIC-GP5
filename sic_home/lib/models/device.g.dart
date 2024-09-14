// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      dataType: $enumDecode(_$DeviceDataTypeEnumMap, json['dataType']),
      userId: json['userId'] as String,
      placeId: (json['placeId'] as num).toInt(),
      sectionId: (json['sectionId'] as num).toInt(),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dataType': _$DeviceDataTypeEnumMap[instance.dataType]!,
      'userId': instance.userId,
      'placeId': instance.placeId,
      'sectionId': instance.sectionId,
    };

const _$DeviceDataTypeEnumMap = {
  DeviceDataType.integer: 0,
  DeviceDataType.float: 1,
  DeviceDataType.string: 2,
  DeviceDataType.boolean: 3,
};
