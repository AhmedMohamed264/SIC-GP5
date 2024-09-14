import 'package:json_annotation/json_annotation.dart';

part 'create_section_model.g.dart';

@JsonSerializable()
class CreateSectionModel {
  String name;
  String userId;
  int placeId;

  CreateSectionModel({
    required this.name,
    required this.userId,
    required this.placeId,
  });

  factory CreateSectionModel.fromJson(Map<String, dynamic> json) =>
      _$CreateSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSectionModelToJson(this);
}
