import 'package:json_annotation/json_annotation.dart';
import 'package:sic_home/models/section.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  int id;
  String name;
  String userId;
  List<Section> sections;

  Place({
    required this.id,
    required this.name,
    required this.userId,
    required this.sections,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
