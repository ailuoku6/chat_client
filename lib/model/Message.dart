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

//  Map toMap(){
//    Map<String,dynamic> data = new Map();
//
//    data['id'] = id;
//    data['from'] = from;
//    data['to'] = to;
//    data['msg'] = msg;
//    data['isread'] = isread;
//    data['time'] = time;
//
//    return data;
//  }

@override
  String toString() {
    // TODO: implement toString
    return 'from:'+from.toString()+"say:"+msg+"date:"+time.toIso8601String();
  }



}