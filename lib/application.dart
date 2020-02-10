import 'package:fluro/fluro.dart';
import 'package:chat_client/model/User.dart';
import 'package:chat_client/model/Contact.dart';
import 'package:rxdart/rxdart.dart';

class Application{
  static Router router;
  static User user = null;
  static Map<int,Contact> contacts = new Map();
  static PublishSubject subject = new PublishSubject<Map<int,Contact>>();
  static PublishSubject subject1 = new PublishSubject<Map<String,dynamic>>();

  static void reflashSubject(){
    subject.add(contacts);
  }
}