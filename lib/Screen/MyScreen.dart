import 'package:chat_client/Utils/SharedPreferencesUtil.dart';
import 'package:chat_client/application.dart';
import 'package:chat_client/route/mNavigator.dart';
import 'package:chat_client/socket/socketUtil.dart';
import 'package:chat_client/widget/OptionItem.dart';
import 'package:flutter/material.dart';
import 'package:chat_client/widget/MyBackground.dart';

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}


class _MyScreenState extends State<MyScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    socketUtil.getSocket().on('offline', (data){
//      print('监听到离线');
//      if(mounted&&data['id']==Application.user.id){
//
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              color: Colors.blue,
              height: 270,
              child: Stack(
                children: <Widget>[
                  MyBackground(heightPercentange: 0.5,),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blueAccent,
                            child: Text(Application.user.nickname[0],style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.white))
                        ),
                        Text(Application.user.nickname,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.white)),
                      ],
                    )
                  ),
                ],
              )
          ),
          Positioned(
            top: 220,
            bottom: 20,
            left: 8,
            right: 8,
            child: Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:OptionItem('用户名', Application.user.username, Icons.account_circle)
                  ),
                ),
                Card(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:OptionItem('昵称', Application.user.nickname, Icons.account_circle)
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text("退出登陆/切换账号"),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: (){
                    socketUtil.offline();
                    SharedPreferencesUtil.setData('', 'user');
                    String username = Application.user.username;
                    String password = Application.user.password;
                    Application.user = null;
                    NavigatorUtil.goLoginPage(context,clearStack: true,username: username,password: password);
                  },
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}
