import 'package:json_annotation/json_annotation.dart';
import 'package:sic_home/models/device.dart';

part 'update_device_model.g.dart';

@JsonSerializable()
class UpdateDeviceModel {
  String name;
  DeviceDataType dataType;
  int placeId;
  int sectionId;

  UpdateDeviceModel({
    required this.name,
    required this.dataType,
    required this.placeId,
    required this.sectionId,
  });

  factory UpdateDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateDeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDeviceModelToJson(this);
}
