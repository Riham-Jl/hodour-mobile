// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_mobile_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminMobileApplication _$AdminMobileApplicationFromJson(
        Map<String, dynamic> json) =>
    AdminMobileApplication(
      id: (json['id'] as num).toInt(),
      platform: json['platform'] as String,
      version: json['version'] as String,
      status: $enumDecode(_$MobileApplicationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$AdminMobileApplicationToJson(
        AdminMobileApplication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'platform': instance.platform,
      'version': instance.version,
      'status': _$MobileApplicationStatusEnumMap[instance.status]!,
    };

const _$MobileApplicationStatusEnumMap = {
  MobileApplicationStatus.forcedUpdate: 'forced-update',
  MobileApplicationStatus.optionalUpdate: 'optional-update',
  MobileApplicationStatus.supported: 'supported',
};
