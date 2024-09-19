import 'package:json_annotation/json_annotation.dart';
import 'package:sic_home/models/device.dart';

part 'create_device_model.g.dart';

@JsonSerializable()
class CreateDeviceModel {
  String name;
  DeviceType deviceType;
  String userId;
  int placeId;
  int sectionId;
  int pin;

  CreateDeviceModel({
    required this.name,
    required this.deviceType,
    required this.userId,
    required this.placeId,
    required this.sectionId,
    required this.pin,
  });

  factory CreateDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$CreateDeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDeviceModelToJson(this);
}
