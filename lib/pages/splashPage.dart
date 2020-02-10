import 'dart:convert';

import 'package:chat_client/Utils/SharedPreferencesUtil.dart';
import 'package:chat_client/Utils/ToastUtil.dart';
import 'package:chat_client/application.dart';
import 'package:chat_client/route/mNavigator.dart';
import 'package:chat_client/socket/socketUtil.dart';
import 'package:flutter/material.dart';
import 'package:chat_client/model/User.dart';

class SplashPage extends StatefulWidget{
  @override
  _SplashPageState createState()=>_SplashPageState();

}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    socketUtil.getSocket().on("loginResult", (data){
//      if(mounted&&context!=null){
//        if(data['result']){
//          //登陆成功
//          print("登录成功");
//          NavigatorUtil.goHomePage(context);
//        }else{
//          //登录失败
//          NavigatorUtil.goLoginPage(context,clearStack: true,username: Application.user.username,password: Application.user.password);
//        }
//      }
//    });
    Application.subject1.stream.listen((data){
      if(mounted&&context!=null){
        if(data['result']){
          //登陆成功
          print("登录成功");
          NavigatorUtil.goHomePage(context);
        }else{
          //登录失败
          NavigatorUtil.goLoginPage(context,clearStack: true,username: Application.user.username,password: Application.user.password);
        }
      }
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      goPage();
    });
  }

  void goPage() async{
//    NavigatorUtil.goHomePage(context);
    //socketUtil.getSocket();
    //判断跳转

    String user = await SharedPreferencesUtil.getData('user');
    print(user);
    if(user.isEmpty){
      //跳转登录页
      NavigatorUtil.goLoginPage(context,clearStack: true);
    }else{
      //进行登陆，结果返回false也跳转登录页
      Application.user = User.fromJson(jsonDecode(user));
      print(Application.user);
      if(socketUtil.getSocket().connected){
        //socketUtil.getSocket().emit('login',{'username':Application.user.username,'password':Application.user.password});
        socketUtil.login(Application.user.username, Application.user.password);
      }else{
        ToastUtil.ShowLongToast('网络未连接或服务器故障');
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
//      appBar: AppBar(
//        title: Text("test"),
//      ),
        body: Center(
          child: Text("welcome to oQ"),
        )
    );
  }

}