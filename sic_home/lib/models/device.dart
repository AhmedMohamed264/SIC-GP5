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

@JsonSerializable()
class Device {
  int id;
  String name;
  DeviceDataType dataType;
  String userId;
  int placeId;
  int sectionId;

  Device({
    required this.id,
    required this.name,
    required this.dataType,
    required this.userId,
    required this.placeId,
    required this.sectionId,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
