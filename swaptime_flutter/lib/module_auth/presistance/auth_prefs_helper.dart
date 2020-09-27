import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swaptime_flutter/module_auth/enums/auth_source.dart';

@provide
class AuthPrefsHelper {
  Future<void> setUserId(String userId) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.setString('uid', userId);
    return;
  }

  Future<String> getUserId() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getString('uid');
  }

  Future<void> setUsername(String username) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.setString('username', username);
  }

  Future<String> getUsername() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getString('username');
  }

  Future<bool> isSignedIn() async {
    String uid = await getUserId();
    return uid != null;
  }

  Future<AUTH_SOURCE> getAuthSource() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getInt('auth_source') as AUTH_SOURCE;
  }

  Future<void> setAuthSource(AUTH_SOURCE authSource) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.setInt(
      'auth_source',
      authSource == null ? null : authSource.index,
    );
  }

  Future<void> clearPrefs() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.clear();
  }
}
