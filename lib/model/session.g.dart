// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      (json['id'] as num).toInt(),
      DateTime.parse(json['session'] as String),
    )
      ..note = json['note'] as String?
      ..attendance = json['attendance'] as String?;

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'session': instance.session.toIso8601String(),
      'note': instance.note,
      'attendance': instance.attendance,
    };
