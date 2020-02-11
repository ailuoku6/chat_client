import 'package:chat_client/application.dart';
import 'package:chat_client/model/Contact.dart';
import 'package:chat_client/model/User.dart';
import 'package:chat_client/route/mNavigator.dart';
import 'package:chat_client/socket/socketUtil.dart';
import 'package:chat_client/widget/Contact.dart';
import 'package:flutter/material.dart';
import 'package:chat_client/model/Message.dart';
import 'package:chat_client/Screen/ContactScreen.dart';
import 'package:chat_client/Screen/MyScreen.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  int _currentIndex = 0;
  final _selectColor = Colors.blue;
  final _unselectColor = Colors.black45;
  PageController _pageController = new PageController();

  var pages = <Widget>[
    ContactScreen(),
    MyScreen(),
  ];

  var titles = <String>[
    '消息',
    '我的'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _pageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
      ),
      body: PageView.builder(
        onPageChanged: _pageChange,
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (BuildContext context,int index){
          return pages.elementAt(index);
        },
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
//          _pageController.animateToPage(index);
          _pageController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      )
    );
  }

}