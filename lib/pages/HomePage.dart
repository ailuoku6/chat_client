import 'package:chat_client/application.dart';
import 'package:chat_client/model/Contact.dart';
import 'package:chat_client/model/User.dart';
import 'package:chat_client/route/mNavigator.dart';
import 'package:chat_client/socket/socketUtil.dart';
import 'package:chat_client/widget/Contact.dart';
import 'package:flutter/material.dart';
import 'package:chat_client/model/Message.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  int _currentIndex = 0;
  final _selectColor = Colors.blue;
  final _unselectColor = Colors.black45;

  //List<Contact> contacts = new List();
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
//    socketUtil.getSocket().on('getOnlineUserResult', (data){
//      print(data['onlineUsers'].runtimeType);
//      List<dynamic> l = data['onlineUsers'];
//      List<User> onlineUsers = l.map((dynamic item)=>User.fromJson(item)).toList();
//      for(User user in onlineUsers){
//        if(contacts[user.id]==null){
//          contacts[user.id] = Contact(user,1);
//        }
//      }
//      setState(() {
//        contacts;
//      });
//      print(onlineUsers);
//      print(contacts.values.toList());
//    });

//    socketUtil.getSocket().on('online', (data){
//      //{user:{id:aUser.id,username:aUser.username,nickname:aUser.nickname}}
//      User user = User.fromJson(data['user']);
//      if(contacts[user.id]==null){
//        contacts[user.id] = Contact(user, 1);
//      }else{
//        contacts[user.id].online = 1;
//      }
//
//      setState(() {
//        contacts;
//      });
//    });

//    socketUtil.getSocket().on('offline', (data){
//      if(contacts[data['id']]!=null){
//        contacts[data['id']].online = 0;
//      }
//      setState(() {
//        contacts;
//      });
//    });

//    socketUtil.getSocket().on('receiveMsg', (data){
//      print(data);
//      Message msg = Message.fromJson(data['msg']);
//      print(msg);
//      if(contacts[msg.from]!=null){
//        contacts[msg.from].msgs.add(msg);
//      }
//      setState(() {
//        contacts;
//      });
//    });

//    socketUtil.getSocket().on('getMsgResult', (data){
//      if(data['result']){
//        List<dynamic> l = data['from'];
//        List<User> fromUsers = l.map((dynamic item)=>User.fromJson(item)).toList();
//        for(User user in fromUsers){
//          if(contacts[user.id]==null){
//            contacts[user.id] = Contact(user, 0);
//          }
//        }
//
//        List<dynamic> l1 = data['msgs'];
//        List<Message> msgs = l1.map((dynamic item)=>Message.fromJson(item)).toList();
//        for(Message msg in msgs){
//          if(contacts[msg.from]!=null){
//            contacts[msg.from].msgs.add(msg);
//          }
//        }
//
//        setState(() {
//          contacts;
//        });
//      }
//    });

    socketUtil.getOnlineUser();
    socketUtil.getUnreadMsg();
  }

  Future<void> _initData() async {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('消息'),
      ),
      body: Container(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,color: _currentIndex==0?_selectColor:_unselectColor),
            title: Text('消息',style: TextStyle(color: _currentIndex==0?_selectColor:_unselectColor))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle,color: _currentIndex==1?_selectColor:_unselectColor,),
              title: Text('我的',style: TextStyle(color: _currentIndex==1?_selectColor:_unselectColor))
          )
        ],
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
      )
    );
  }

}