import 'package:hodor/model/response_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'error.dart';

part 'response_model.g.dart';

@JsonSerializable(explicitToJson: true,genericArgumentFactories: true)
class ResponseModel <T> {
  late T? data;
  late Error? error ;
  late ResponseStatus status;



  ResponseModel({required this.data,
    required this.status});

  ResponseModel.Error({required this.error}){
    status = ResponseStatus.failed ;
  }

  factory ResponseModel.fromJson(Map<String, dynamic> json,
      T Function( Object? json) fromJsonT) => _$ResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ResponseModelToJson(this, toJsonT);

}