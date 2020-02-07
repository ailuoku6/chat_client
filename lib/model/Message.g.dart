// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['id'] as int,
    json['from'] as int,
    json['to'] as int,
    json['msg'] as String,
    json['isread'] as int,
    json['time'] == null ? null : DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'from': instance.from,
      'to': instance.to,
      'msg': instance.msg,
      'isread': instance.isread,
      'time': instance.time?.toIso8601String(),
    };
