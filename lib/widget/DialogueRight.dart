import 'package:flutter/material.dart';

class DialogueRight extends StatelessWidget {

  final String nickname;
  final String msg;
  final Color avatarColor = Colors.blueAccent;
  DialogueRight(this.nickname, this.msg);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(nickname,style: TextStyle(fontSize: 12),),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: avatarColor,
                    child: Text(msg,style: TextStyle(fontSize: 16,backgroundColor: avatarColor,color: Colors.white),),
                  ),

                ],
              ),
            ),
          ),


          CircleAvatar(
              backgroundColor: avatarColor,
              child: Text(nickname[0]??'?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.white))
          ),
        ],
      ),
    );
  }
}
