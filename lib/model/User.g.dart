part of 'User.dart';

User _$UserFromJson(Map<String,dynamic> json){
  return User(json['id'] as int, json['username'] as String, json['password'] as String, json['nickname'] as String);
}

Map<String,dynamic> _$UserToJson(User instance) => <String ,dynamic>{
  'id':instance.id,
  'username':instance.username,
  'password':instance.password,
  'nickname':instance.nickname
};