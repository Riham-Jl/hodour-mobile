// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['note'] as String?,
      json['attendance'] as bool?,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'note': instance.note,
      'attendance': instance.attendance,
    };
