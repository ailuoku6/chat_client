import 'package:flutter/material.dart';

class DialogueLeft extends StatelessWidget {

  final String nickname;
  final String msg;
  final Color avatarColor = Colors.blueAccent;
  DialogueLeft(this.nickname, this.msg);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              backgroundColor: avatarColor,
              child: Text(nickname[0]??'?',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.white))
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(nickname,style: TextStyle(fontSize: 12),),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: avatarColor,
                  child: Text(msg,style: TextStyle(fontSize: 16,backgroundColor: avatarColor,color: Colors.white),),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

