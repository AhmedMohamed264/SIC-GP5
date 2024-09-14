import 'package:json_annotation/json_annotation.dart';
import 'package:sic_home/models/device.dart';

part 'section.g.dart';

@JsonSerializable()
class Section {
  int id;
  String name;
  String userId;
  int placeId;
  List<Device> devices;

  Section({
    required this.id,
    required this.name,
    required this.userId,
    required this.placeId,
    required this.devices,
  });

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);
}
