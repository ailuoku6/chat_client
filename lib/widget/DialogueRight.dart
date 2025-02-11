import 'package:flutter/material.dart';

class DialogueRight extends StatelessWidget {

  final String nickname;
  final String msg;
  final Color avatarColor = Colors.blueAccent;
  final int status;
  DialogueRight(this.nickname, this.msg,this.status);

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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      color: avatarColor
                    ),
                    padding: const EdgeInsets.all(15),
//                    color: avatarColor,
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
