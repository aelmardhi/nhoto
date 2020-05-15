// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return $checkedNew('Location', json, () {
    final val = Location(
        $checkedConvert(json, 'id', (v) => v as int),
        $checkedConvert(json, 'name', (v) => v as String),
        $checkedConvert(json, 'imgePath', (v) => v as String),
        $checkedConvert(json, 'subTitle', (v) => v as String),
        $checkedConvert(json, 'text', (v) => v as String));
    return val;
  }, fieldKeyMap: const {'imagePath': 'imgePath', 'subtitle': 'subTitle'});
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imgePath': instance.imagePath,
      'subTitle': instance.subtitle,
      'text': instance.text
    };
