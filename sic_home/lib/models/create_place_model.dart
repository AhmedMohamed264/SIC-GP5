import 'package:json_annotation/json_annotation.dart';

part 'create_place_model.g.dart';

@JsonSerializable()
class CreatePlaceModel {
  String name;
  String userId;

  CreatePlaceModel({
    required this.name,
    required this.userId,
  });

  factory CreatePlaceModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePlaceModelToJson(this);
}
