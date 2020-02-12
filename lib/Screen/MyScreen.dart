import 'package:chat_client/application.dart';
import 'package:flutter/material.dart';
import 'package:chat_client/widget/MyBackground.dart';

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}


class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 270,
            child: Stack(
              children: <Widget>[
                MyBackground(heightPercentange: 0.5,),
                Center(
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blueAccent,
                      child: Text(Application.user.nickname[0],style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300,color: Colors.white))
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
