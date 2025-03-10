import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<String?> get refreshToken async {
    return _sharedPreference.getString(Preferences.refresh_token);
  }

  Future<int?> get expireTime async {
    return _sharedPreference.getInt(Preferences.expire_time);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> saveRefreshToken(String refreshToken) async {
    return _sharedPreference.setString(Preferences.refresh_token, refreshToken);
  }

  Future<bool> saveExpireTime(int expireTime) async {
    return _sharedPreference.setInt(Preferences.expire_time, expireTime);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }
}
