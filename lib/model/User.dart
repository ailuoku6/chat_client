import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';
@JsonSerializable()
class User{
  int id;
  String username;
  String password;
  String nickname;

  User(this.id, this.username, this.password, this.nickname);

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  Map<String,dynamic> toJson() => _$UserToJson(this);


//  Map userMap = JSON.decode(json);
//  var user = new User.fromJson(userMap);
//  String json = JSON.encode(user);
  @override
  String toString() {
    // TODO: implement toString
    return username +":"+password;
  }

}