import 'package:the_news/app/data/shared_preference/shared_preference.dart';

import '../../core/constants/constants.dart';

class UserPreferences {
  static final sharedPreferences = SharedPrefs.instance;

  static String getUserToken() => sharedPreferences.getString(userToken) ?? '';
  static String getUserPhoneNumber() => sharedPreferences.getString(userPhoneNumber) ?? 'error phone number';
  static String getUserId() => sharedPreferences.getString(userId) ?? '';

  static Future<void> setUserToken(String token) => sharedPreferences.setString(userToken, token);
  static Future<void> setUserId(String userID) => sharedPreferences.setString(userId, userID);
  static Future<void> setUserPhoneNumber(String phoneNumber) => sharedPreferences.setString(userPhoneNumber, phoneNumber);
}
