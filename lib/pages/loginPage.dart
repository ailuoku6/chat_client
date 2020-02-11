import 'dart:convert';

import 'package:chat_client/Utils/SharedPreferencesUtil.dart';
import 'package:chat_client/Utils/ToastUtil.dart';
import 'package:chat_client/application.dart';
import 'package:chat_client/model/User.dart';
import 'package:chat_client/route/mNavigator.dart';
import 'package:chat_client/socket/socketUtil.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{

  String username;
  String password;

  LoginPage(this.username, this.password);

  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{

//  String _username;
//  String _password;

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _unameController_sign = new TextEditingController();
  TextEditingController _pwdController_sign = new TextEditingController();
  TextEditingController _nickController_sign = new TextEditingController();
  bool pwdShow = true; //密码是否显示明文
  bool _isLogin = true;

  Widget _loginWidget;
  Widget _signUpWidget;



  void _initWidget(){
    _loginWidget = Card(
      elevation: 5,
      child:Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[

            Text("LOGIN",style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.w500
            ),),
            TextField(
              controller: _unameController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "用户名",
//                        hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)
              ),
            ),
            TextField(
              controller: _pwdController,
              decoration: InputDecoration(
                  labelText: "密码",
//                        hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)
              ),
              obscureText: pwdShow,
            ),
            RaisedButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("登录"),
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: ()=>_handleLogin(),
            ),
            InkWell(
              child: Text('没有账号，注册一个'),
              onTap: (){
                setState(() {
                  _isLogin = false;
                });
              },
            )
          ],
        ),
      ),
    );

    _signUpWidget = Card(
      elevation: 5,
      child:Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[

            Text("SIGNUP",style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.w500
            ),),
            TextField(
              controller: _unameController_sign,
              decoration: InputDecoration(
                  labelText: "用户名",
//                        hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)
              ),
            ),
            TextField(
              controller: _nickController_sign,
              decoration: InputDecoration(
                  labelText: "昵称",
                  prefixIcon: Icon(Icons.assignment_ind)
              ),
            ),

            TextField(
              controller: _pwdController_sign,
              decoration: InputDecoration(
                  labelText: "密码",
//                        hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)
              ),
              obscureText: pwdShow,
            ),
            RaisedButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("注册"),
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: ()=>_handleSignUp(),
            ),
            InkWell(
              child: Text('已有账号，我要登陆'),
              onTap: (){
                setState(() {
                  _isLogin = true;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _unameController.text = widget.username;
    _pwdController.text = widget.password;

    Application.subject1.stream.listen((data){
      if(mounted&&context!=null){
        if(data['result']){
          //登陆成功
          Application.user = User.fromJson(data['user']);
          ToastUtil.ShowShortToast('登录成功');
          data['user']['password'] = _pwdController.text;

          print(Application.user);
          SharedPreferencesUtil.setData(jsonEncode(Application.user.toJson()), 'user');
          NavigatorUtil.goHomePage(context);
        }else{
          //失败
          ToastUtil.ShowShortToast(data['msg']??'');
        }
      }
    });

    _initWidget();
  }

  _handleLogin() async{
    //socketUtil.getSocket().emit('login',{'username':_unameController.text,'password':_pwdController.text});
    socketUtil.login(_unameController.text, _pwdController.text);
  }

  _handleSignUp() async{
    socketUtil.signup(_unameController_sign.text, _pwdController_sign.text,_nickController_sign.text);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('注册/登陆'),
          backgroundColor:new Color(0x00000000),
          elevation:0
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 80),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: _loginWidget,
          secondChild: _signUpWidget,
          crossFadeState: _isLogin?CrossFadeState.showFirst:CrossFadeState.showSecond,
        ),
      ),
    );
  }

}