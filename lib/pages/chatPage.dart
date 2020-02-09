import 'package:chat_client/application.dart';
import 'package:chat_client/model/Contact.dart';
import 'package:chat_client/model/Message.dart';
import 'package:flutter/material.dart';

class chatPage extends StatefulWidget {

  int _id;
  @override
  _chatPageState createState() => _chatPageState();

  chatPage(this._id);

}

class _chatPageState extends State<chatPage> {

  List<Message> _messages = new List();
  Map<int,Contact> _contacts = new Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Application.subject.stream.listen((data){

      if(mounted){
        print("刷新");
        setState(() {
          _messages = data[widget._id].msgs;
          _contacts = data;
        });
      }
    });
    Application.reflashSubject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_contacts[widget._id]!=null?Text(_contacts[widget._id].user.nickname+'('+(_contacts[widget._id].online==1?'在线':'离线')+')'):null),
      ),
    );
  }
}
