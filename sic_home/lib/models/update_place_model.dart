import 'package:json_annotation/json_annotation.dart';

part 'update_place_model.g.dart';

@JsonSerializable()
class UpdatePlaceModel {
  String name;

  UpdatePlaceModel({
    required this.name,
  });

  factory UpdatePlaceModel.fromJson(Map<String, dynamic> json) =>
      _$UpdatePlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePlaceModelToJson(this);
}
