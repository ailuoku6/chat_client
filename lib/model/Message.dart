import 'package:json_annotation/json_annotation.dart';

part 'Message.g.dart';
@JsonSerializable()
class Message{
  int id;
  int from;
  int to;
  String msg;
  int isread;
  DateTime time;

  Message(this.id, this.from, this.to, this.msg, this.isread, this.time);

  factory Message.fromJson(Map<String,dynamic> json) => _$MessageFromJson(json);
  Map<String,dynamic> toJson() => _$MessageToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    return 'id:'+id.toString()+'from:'+from.toString()+"say:"+msg+"date:"+time.toIso8601String();
  }

  @override
  bool operator ==(other) {
    // TODO: implement ==
    //return super == other;
    return this.id==other.id;
  }

}