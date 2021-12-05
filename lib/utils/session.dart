import 'package:shared_preferences/shared_preferences.dart';

class Session{
  static final String ACCOUNT_SESSION_KEY = 'accountModel';
  static final String TOKEN_SESSION_KEY = 'accessToken';
  static final String REMEMBER_LOGIN = 'rememberLogin';
  static final String USERID_SESSION_KEY = 'userId';
  static final String PASSWD_KEY = 'passwd';
  static final String REASON = 'reason';

  static Future<void> set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.get(key);
    if(value != null){
      return value;
    }
    return null;
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

}