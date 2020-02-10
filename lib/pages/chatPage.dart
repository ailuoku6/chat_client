import 'package:chat_client/application.dart';
import 'package:chat_client/model/Contact.dart';
import 'package:chat_client/model/Message.dart';
import 'package:chat_client/socket/socketUtil.dart';
import 'package:flutter/gestures.dart';
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
  ScrollController _scrollController = new ScrollController();
  TextEditingController _textEditingController = new TextEditingController();
  final double bottomSheetHigh = 80.0;

  int _startIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //把相应信息标为已读
    Application.subject.stream.listen((data){

      if(mounted){
        print("刷新");
        _messages = data[widget._id].msgs;
        _contacts = data;

        List<Message> unreadMsgs = new List();
        for(int i = _startIndex;i<_messages.length;i++){
          if(_messages[i].isread==0&&_messages[i].from==widget._id)
            unreadMsgs.add(_messages[i]);
        }

        if(unreadMsgs.length>0){
          socketUtil.readEdMsg(unreadMsgs);
        }

        setState(() {
          _messages;
          _contacts;
        });
      }
    });
    Application.reflashSubject();
  }

  Future<void> _initData() async {

  }

  void _sendMsg(){
    int to = widget._id;
    String msg = _textEditingController.text;
    String key = to.toString() + "-" + _messages.length.toString();
    if(msg=='') return;

    Map<int,Contact> contacts = Application.contacts;
    contacts[to].msgs.add(new Message(-1,Application.user.id,to,msg,0,new DateTime.now()));
    Application.contacts = contacts;
    Application.reflashSubject();
    socketUtil.sendMsg(to, msg, key);

    _textEditingController.text = '';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_contacts[widget._id]!=null?Text(_contacts[widget._id].user.nickname+'('+(_contacts[widget._id].online==1?'在线':'离线')+')'):null),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: bottomSheetHigh-10),
        child: RefreshIndicator(
          onRefresh: _initData,
          child: ListView.builder(
            itemCount: _messages.length,
            controller: _scrollController,
            itemBuilder: (BuildContext context,int index){

              Message msg = _messages[index];

              return msg.from==Application.user.id?(DialogueRight(Application.user.nickname, msg.msg)):(DialogueLeft(_contacts[msg.from].user.nickname, msg.msg));
            },
          ),
        ),
      ),
//      bottomNavigationBar: Container(
//        height: 90,
//        color: Colors.black12,
//        child: TextField(
//          decoration: InputDecoration(
//              labelText: "",
////                        hintText: "用户名或邮箱",
//          ),
//        ),
//      ),
      bottomSheet: Container(
        height: bottomSheetHigh,
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: "",
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    child: Text("发送"),
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    onPressed: ()=>_sendMsg(),
                  ),
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
