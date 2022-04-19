import 'package:shared_preferences/shared_preferences.dart';
class sf{
  static String sharedprefrenceLoggerInKey = "ISLOGGEDIN";
  static String sharedprefrenceMobileNumber = "Mobile_No";
  static Future<bool> saveUserLoggedInState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedprefrenceLoggerInKey, isLoggedIn);
  }
  static Future<bool> saveMobileNumberInSharedPrefrence(String MobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedprefrenceMobileNumber, MobileNumber);
  }
  static Future<bool?> getUserLoggedInState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedprefrenceLoggerInKey);
  }
  static Future<String?> getUserNameFromSharedPrefrence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedprefrenceMobileNumber);
  }
}
