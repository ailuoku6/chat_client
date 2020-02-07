import 'package:chat_client/application.dart';
import 'package:chat_client/route/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:chat_client/pages/loginPage.dart';

class NavigatorUtil{
  static _navigateTo(BuildContext context,String path,{
    bool replace = false,
    bool clearStack = false,
    Duration transitionDuration = const Duration(milliseconds: 250),
    RouteTransitionsBuilder transitionsBuilder
  }){
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionsBuilder,
        transition: TransitionType.material);
  }

  static void Back(BuildContext context){
    Application.router.pop(context);
  }

  static void goLoginPage(BuildContext context,{clearStack:true,username:'',password:''}) {
    _navigateTo(context, Routes.login.replaceAll(':user', Uri.encodeComponent(username)).replaceAll(':psw', Uri.encodeComponent(password)), clearStack: clearStack);
  }

  static void goHomePage(BuildContext context){
    _navigateTo(context, Routes.home,clearStack: true);
  }
//
//  static void goSearchPage(BuildContext context){
//    _navigateTo(context, Routes.search,clearStack: false);
//  }
//
//  static void goSearchResult(BuildContext context,{kw:""}){
//    _navigateTo(context, Routes.searchResult.replaceAll(":kw", kw),clearStack: false);
//  }
//  static void goNoticeDetail(BuildContext context,{url:""}){
//    _navigateTo(context, Routes.noticeDetail.replaceAll(":url", Uri.encodeComponent(url)),clearStack: false);
//  }
//  static void goMyBorrow(BuildContext context){
//    _navigateTo(context, Routes.myBorrow,clearStack: false);
//  }

}