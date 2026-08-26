
import 'package:json_annotation/json_annotation.dart';

enum ResponseStatus {
  @JsonValue("Success")
  success ,
  @JsonValue("Failed")
  failed
}