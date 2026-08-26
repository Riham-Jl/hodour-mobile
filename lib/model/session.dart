import 'package:hodor/core/functions/date_functions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';


@JsonSerializable(explicitToJson: true)
class Session {
  int id;

  DateTime session;

  String? note;

  String? attendance;

  Session (this.id , this.session) ;

  String sessionString(){
    return getStringDateFromDateTime(session);
  }


  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

}
