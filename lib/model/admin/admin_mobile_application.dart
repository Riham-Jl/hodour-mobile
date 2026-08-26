import 'package:json_annotation/json_annotation.dart';

part 'admin_mobile_application.g.dart';

enum MobileApplicationStatus {
  @JsonValue('forced-update')
  forcedUpdate,

  @JsonValue('optional-update')
  optionalUpdate,

  @JsonValue('supported')
  supported,
}

@JsonSerializable()
class AdminMobileApplication {
  final int id;
  String platform;
  String version;
  MobileApplicationStatus status;

  AdminMobileApplication({
    required this.id,
    required this.platform,
    required this.version,
    required this.status,
  });

  factory AdminMobileApplication.fromJson(Map<String, dynamic> json) =>
      _$AdminMobileApplicationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminMobileApplicationToJson(this);
}