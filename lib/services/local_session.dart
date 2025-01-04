import 'package:shared_preferences/shared_preferences.dart';

class LocalSession {
  static String accessToken = "access_token";

  //theme set and get
  Future<bool> setAccessToken(String value) async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    bool status = await sf.setString(accessToken, value);
    return status;
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    String? result = sf.getString(accessToken);
    return result;
  }

  Future<bool> clearPrefData() async {
    try {
      final SharedPreferences sf = await SharedPreferences.getInstance();
      return await sf.clear();
    } catch (e) {
      // Log or handle the error if needed
      print('Error clearing preferences: $e');
      return false; // Return false if clearing fails
    }
  }

  // static Future<void> saveUserToSharedPreferences(User user) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String userJson = json.encode(user.toJson());
  //
  //   await prefs.setString('userKey', userJson);
  // }
  //
  // static Future<User?> getUserFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userJson = prefs.getString('userKey');
  //
  //
  //   if (userJson != null) {
  //     Map<String, dynamic> userMap = json.decode(userJson);
  //     return User.fromJson(userMap);
  //   } else {
  //     return null;
  //   }
  // }
  //
  // static Future<void> saveBooleanListToSharedPreferences(
  //     List<String> boolList, String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setStringList(key, boolList);
  // }
  //
  // static Future<List<String>> getBooleanListFromSharedPreferences(
  //     String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> boolList = prefs.getStringList(key) ?? [];
  //   return boolList;
  // }
}
