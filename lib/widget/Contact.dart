import 'package:flutter/material.dart';

class conTactItem extends StatelessWidget{
  final String name;
  final String lastMsg;
  final String date;
  final int online;

  final Function onPress;

  final Color onlineColor = Colors.blueAccent;
  final Color unlineColor = Colors.black38;


  const conTactItem({Key key,this.name, this.lastMsg, this.date,this.online,this.onPress}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: (){
        onPress();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: online==1?onlineColor:unlineColor,
              child: Text(name[0]??'?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.white))
            ),
            //IconButton(icon: Text(name[0]??'?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.white,backgroundColor: Colors.blueAccent)), onPressed: null),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300)),
                  Text(lastMsg,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}