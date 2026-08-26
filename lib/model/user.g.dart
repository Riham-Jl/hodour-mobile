// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      access_token: json['access_token'] as String?,
      image: json['image'] as String?,
      is_admin: json['is_admin'] as bool?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'access_token': instance.access_token,
      'image': instance.image,
      'is_admin': instance.is_admin,
      'language': instance.language,
    };
