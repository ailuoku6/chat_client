import 'package:chat_client/route/routerHandle.dart';
import 'package:fluro/fluro.dart';
import 'package:chat_client/pages/loginPage.dart';
import 'package:flutter/material.dart';

class Routes{
  static String root = "/";
  static String login = "/login/:user/:psw";
  static String home = '/home';

  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context,Map<String,List<String>> params){
      return LoginPage('','');
    });

    router.define(home, handler:homeHandle);
    router.define(login, handler: loginHandle);
//    router.define(search, handler: searchHandle);
//    router.define(searchResult, handler: searchResultHandle);
//    router.define(noticeDetail, handler: noticeDetailHandle);
//    router.define(myBorrow, handler: myBorrowHandle);
  }
}