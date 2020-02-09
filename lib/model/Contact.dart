import 'package:chat_client/model/User.dart';
import 'package:chat_client/model/Message.dart';
class Contact{
  User user;
  int online;
  List<Message> msgs = new List();

  Contact(this.user,this.online);

  @override
  String toString() {
    // TODO: implement toString
    return user.toString() + msgs.toString();
  }

}