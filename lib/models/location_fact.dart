import 'package:json_annotation/json_annotation.dart';

part 'location_fact.g.dart';

@JsonSerializable()
class LocationFact {
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'text')
  final String text;

  LocationFact(this.title, this.text);

  factory LocationFact.fromJson(Map<String,dynamic> json) => _$LocationFactFromJson(json);
  Map<String,dynamic> toJson() => _$LocationFactToJson(this);
}