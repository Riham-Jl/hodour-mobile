// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurrent_absent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurrentAbsent _$RecurrentAbsentFromJson(Map<String, dynamic> json) =>
    RecurrentAbsent(
      json['key'] as String,
      (json['members'] as List<dynamic>)
          .map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecurrentAbsentToJson(RecurrentAbsent instance) =>
    <String, dynamic>{
      'key': instance.key,
      'members': instance.members.map((e) => e.toJson()).toList(),
    };
