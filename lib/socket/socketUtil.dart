import 'package:chat_client/application.dart';
import 'package:chat_client/model/Contact.dart';
import 'package:chat_client/model/Message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:chat_client/model/User.dart';

class socketUtil{
  static IO.Socket _socket = IO.io('http://127.0.0.1:3000',<String,dynamic>{
    'transports': ['websocket'],
    'extraHeaders': {'foo': 'bar'},
    'forceNew': true,
  });

  static IO.Socket getSocket(){
    if(_socket==null){
      _socket = IO.io('http://127.0.0.1:3000',<String,dynamic>{
        'transports': ['websocket'],
        'extraHeaders': {'foo': 'bar'},
        'forceNew': true,
      });
    }
    return _socket;
  }

  static void initSocket(){
    getSocket().on('getOnlineUserResult', (data){//获取在线用户

      print(data);

      dynamic contacts = Application.contacts;
      List<dynamic> l = data['onlineUsers'];
      List<User> onlineUsers = l.map((dynamic item)=>User.fromJson(item)).toList();
      for(User user in onlineUsers){
        if(contacts[user.id]==null){
          contacts[user.id] = Contact(user,1);
        }
      }

      Application.contacts = contacts;

      Application.subject.add(Application.contacts);

      print(onlineUsers);
      print(contacts.values.toList());
    });

    getSocket().on('online', (data){
      //{user:{id:aUser.id,username:aUser.username,nickname:aUser.nickname}}
      dynamic contacts = Application.contacts;
      User user = User.fromJson(data['user']);

      if(Application.user!=null&&Application.user.id==user.id){
        return;
      }

      if(contacts[user.id]==null){
        contacts[user.id] = Contact(user, 1);
      }else{
        contacts[user.id].online = 1;
      }

      Application.contacts = contacts;

      Application.subject.add(Application.contacts);

//      setState(() {
//        contacts;
//      });
    });

    getSocket().on('offline', (data){

      dynamic contacts = Application.contacts;

      if(contacts[data['id']]!=null){
        contacts[data['id']].online = 0;
      }

      Application.contacts = contacts;
      Application.subject.add(Application.contacts);
//      setState(() {
//        contacts;
//      });
    });

    getSocket().on('receiveMsg', (data){
      print(data);
      dynamic contacts = Application.contacts;
      Message msg = Message.fromJson(data['msg']);
      print(msg);
      if(contacts[msg.from]!=null){
        contacts[msg.from].msgs.add(msg);
      }
      Application.contacts = contacts;
      Application.subject.add(Application.contacts);
//      setState(() {
//        contacts;
//      });
    });

    getSocket().on('getMsgResult', (data){
      if(data['result']){
        dynamic contacts = Application.contacts;
        List<dynamic> l = data['from'];
        List<User> fromUsers = l.map((dynamic item)=>User.fromJson(item)).toList();
        for(User user in fromUsers){
          if(contacts[user.id]==null){
            contacts[user.id] = Contact(user, 0);
          }
        }

        List<dynamic> l1 = data['msgs'];
        List<Message> msgs = l1.map((dynamic item)=>Message.fromJson(item)).toList();
        for(Message msg in msgs){
          if(contacts[msg.from]!=null){
            contacts[msg.from].msgs.add(msg);
          }
        }

        Application.contacts = contacts;
        Application.subject.add(Application.contacts);

//        setState(() {
//          contacts;
//        });
      }
    });
  }

  static void login(String username,String password){
    getSocket().emit('login',{'username':username,'password':password});
    //触发loginResult事件，返回数据{result:false,msg:'注册失败，用户名已被占用'} 或 {result:true,user:aUser}
    //触发online事件，返回数据{user:{id:aUser.id,username:aUser.username,nickname:aUser.nickname}}
  }

  static void signup(String username,String password){
    getSocket().emit('signUp',{'username':username,'password':password});
    //触发loginResult事件，返回数据{result:false,msg:'注册失败，用户名已被占用'} 或 {result:true,user:aUser}
  }

  static void getUnreadMsg(){
    getSocket().emit('getUnreadMsg');
    //触发getMsgResult事件，返回数据{result:true,msgs:msgs,from:findUsers}
  }

  static void getOnlineUser(){
    getSocket().emit('getOnlineUser');
    //触发getOnlineUserResult事件，返回数据{onlineUsers:onlineUsers}
  }

  static void offline(){
    getSocket().emit('disconnect');
    //触发offline事件，返回数据{id:id},当id为自己时，说明自己离线，并退出应用，否则更新好友列表
  }

  static void sendMsg(int to,String msg,String key){
    getSocket().emit('sendMsg',{'to':to,'msg':msg,'key':key});
    //触发sendFeedback事件，返回数据{result:false,key:key,msg:'非法请求',id:id},表示该条信息是否发送完毕，另有receiveMsg事件，接收别人发的信息，返回的信息为{msg:msg}对应Message类
  }

  static void readEdMsg(dynamic msgs){
    getSocket().emit('readEdMsg',{'msgs':msgs});
  }



}