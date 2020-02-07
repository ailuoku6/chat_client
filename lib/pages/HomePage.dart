import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  int _currentIndex = 0;
  final _selectColor = Colors.blue;
  final _unselectColor = Colors.black45;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('消息'),
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