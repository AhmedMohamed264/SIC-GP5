import 'package:json_annotation/json_annotation.dart';
import 'package:sic_home/models/device.dart';

part 'update_device_model.g.dart';

@JsonSerializable()
class UpdateDeviceModel {
  String name;
  DeviceType deviceType;
  int placeId;
  int sectionId;
  int pin;

  UpdateDeviceModel({
    required this.name,
    required this.deviceType,
    required this.placeId,
    required this.sectionId,
    required this.pin,
  });

  factory UpdateDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateDeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDeviceModelToJson(this);
}
