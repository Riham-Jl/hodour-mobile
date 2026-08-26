import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int id;
  String name;
  String email;
  String? access_token;
  String? image;
  bool? is_admin;
  String? language;




  User({required this.id, required this.name , required this.email , required this.access_token , this.image, this.is_admin , this.language });


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);


}
