import 'package:socket_io_client/socket_io_client.dart' as IO;

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

  static void login(String username,String password){
    getSocket().emit('login',{'username':username,'password':password});
    //触发loginResult事件，返回数据{result:false,msg:'注册失败，用户名已被占用'} 或 {result:true,user:aUser}
  }

  static void signup(String username,String password){
    getSocket().emit('signUp',{'username':username,'password':password});
    //触发loginResult事件，返回数据{result:false,msg:'注册失败，用户名已被占用'} 或 {result:true,user:aUser}
  }

  static void getUnreadMsg(){
    getSocket().emit('getUnreadMsg');
    //触发getMsgResult事件，返回数据{result:true,msgs:msgs}
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

}