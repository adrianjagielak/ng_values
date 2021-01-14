// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Value _$ValueFromJson(Map<String, dynamic> json) {
  return Value(
    id: json['id'] as int,
    text: json['text'] as String,
    canBeDeleted: json['canBeDeleted'] as bool,
  );
}

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'canBeDeleted': instance.canBeDeleted,
    };
