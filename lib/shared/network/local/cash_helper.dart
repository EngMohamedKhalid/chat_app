import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static late SharedPreferences shared;
  static init() async{
    shared = await SharedPreferences.getInstance();
  }

  static Future<bool> setPool({required String key, required dynamic value})async{
    return await shared.setBool(key, value);
  }
  static bool? getPool({
    required String key,
  }){
    return shared.getBool(key);
  }
}