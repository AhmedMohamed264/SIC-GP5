import 'package:json_annotation/json_annotation.dart';

part 'update_section_model.g.dart';

@JsonSerializable()
class UpdateSectionModel {
  String name;
  int placeId;

  UpdateSectionModel({
    required this.name,
    required this.placeId,
  });

  factory UpdateSectionModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSectionModelToJson(this);
}
