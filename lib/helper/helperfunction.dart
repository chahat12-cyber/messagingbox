import 'package:shared_preferences/shared_preferences.dart';

class helperFunction {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharePreferenceUserEmailKey = "USEREMAILKEY";
//saving data to shared preference

  static Future<bool> saveuserLoggedInSharedPreference(
      bool isuserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isuserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userNameKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userNameKey);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharePreferenceUserEmailKey, userEmail);
  }

  //getting data from shared preference

  static Future<bool> getuserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(sharePreferenceUserEmailKey);
  }
}
