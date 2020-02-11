import 'package:chat_client/application.dart';
import 'package:chat_client/model/Contact.dart';
import 'package:chat_client/route/mNavigator.dart';
import 'package:chat_client/widget/Contact.dart';
import 'package:flutter/material.dart';
import 'package:chat_client/socket/socketUtil.dart';
import 'package:chat_client/model/Message.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  Map<int,Contact> contacts = new Map();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Application.subject.stream.listen((data){
      if(mounted){
        setState(() {
          contacts = data;
        });
      }
    });
    _setSocket();
  }

  void _setSocket(){

    socketUtil.getOnlineUser();
    socketUtil.getUnreadMsg();
  }

  Future<void> _initData() async {

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: _initData,
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context,int index){

            Contact contact = contacts.values.toList()[index];

            Message lastMessage = contact.msgs.length>0 ? contact.msgs.last:null;

            return conTactItem(
              name: contact.user.username,
              lastMsg: lastMessage!=null?lastMessage.msg:'',
              date: lastMessage!=null?lastMessage.time.toIso8601String():'',
              online: contact.online,
              onPress: (){
                NavigatorUtil.goChatPage(context,id: contact.user.id);
              },
            );
          },
        ),
      ),
    );
  }
}
