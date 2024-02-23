import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String auth_token = "auth_token";
  late final SharedPreferences prefs;

//setter
  Future<void> setAuthToken(String auth_token) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(this.auth_token, auth_token);
  }

//getter
  Future<String?> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? auth_token;
    auth_token = (pref.getString(this.auth_token) ?? null);
    print("TOKEN IS  :::: " + auth_token!);
    return auth_token;
  }

  clearAll() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
