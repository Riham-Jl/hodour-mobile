import 'package:hodor/model/member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recurrent_absent.g.dart';


@JsonSerializable(explicitToJson: true)
class RecurrentAbsent {
  String key;
  List<Member> members;



  RecurrentAbsent (this.key , this.members ) ;


  factory RecurrentAbsent.fromJson(Map<String, dynamic> json) => _$RecurrentAbsentFromJson(json);

  Map<String, dynamic> toJson() => _$RecurrentAbsentToJson(this);

}


