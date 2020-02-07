import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil{

  static Future<String> getData(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = (prefs.getString(key)??'');
    return data;
  }

  static setData(String data,String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

}