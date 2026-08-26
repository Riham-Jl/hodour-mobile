// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel<T> _$ResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResponseModel<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      status: $enumDecode(_$ResponseStatusEnumMap, json['status']),
    )..error = json['error'] == null
        ? null
        : Error.fromJson(json['error'] as Map<String, dynamic>);

Map<String, dynamic> _$ResponseModelToJson<T>(
  ResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'error': instance.error?.toJson(),
      'status': _$ResponseStatusEnumMap[instance.status]!,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

const _$ResponseStatusEnumMap = {
  ResponseStatus.success: 'Success',
  ResponseStatus.failed: 'Failed',
};

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
