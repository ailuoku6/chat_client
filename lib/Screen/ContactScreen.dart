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
  List<Contact> contactList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Application.subject.stream.listen((data){
      if(mounted){
        contacts = data;
        contactList = contacts.values.toList();
        //排序
        contactList.sort((left,right){
          return left.online.compareTo(right.online);
        });
        setState(() {});
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
          itemCount: contactList.length,
          itemBuilder: (BuildContext context,int index){

//            Contact contact = contacts.values.toList()[index];
            Contact contact = contactList[index];

            Message lastMessage = contact.msgs.length>0 ? contact.msgs.last:null;

            return conTactItem(
              name: contact.user.nickname,
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
