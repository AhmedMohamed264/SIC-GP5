import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

enum DeviceDataType {
  @JsonValue(0)
  integer,
  @JsonValue(1)
  float,
  @JsonValue(2)
  string,
  @JsonValue(3)
  boolean,
}

enum DeviceType {
  @JsonValue(0)
  onoff,
  @JsonValue(1)
  analog,
}

@JsonSerializable()
class Device {
  int id;
  String name;
  DeviceType deviceType;
  String userId;
  int placeId;
  int sectionId;
  int pin;

  Device({
    required this.id,
    required this.name,
    required this.deviceType,
    required this.userId,
    required this.placeId,
    required this.sectionId,
    required this.pin,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
