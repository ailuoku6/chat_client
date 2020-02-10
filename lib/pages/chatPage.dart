import 'package:chat_client/application.dart';
import 'package:chat_client/model/Contact.dart';
import 'package:chat_client/model/Message.dart';
import 'package:flutter/material.dart';
import 'package:chat_client/widget/DialogueLeft.dart';
import 'package:chat_client/widget/DialogueRight.dart';

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

  Future<void> _initData() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_contacts[widget._id]!=null?Text(_contacts[widget._id].user.nickname+'('+(_contacts[widget._id].online==1?'在线':'离线')+')'):null),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: _initData,
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (BuildContext context,int index){

              Message msg = _messages[index];

              return msg.from==Application.user.id?(DialogueRight(_contacts[msg.from].user.nickname, msg.msg)):(DialogueLeft(_contacts[msg.from].user.nickname, msg.msg));
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.black12,
        child: TextField(
          decoration: InputDecoration(
              labelText: "",
//                        hintText: "用户名或邮箱",
          ),
        ),
      ),
    );
  }
}
