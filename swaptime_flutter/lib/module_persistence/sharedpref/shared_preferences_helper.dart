import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class SharedPreferencesHelper {
  Future<void> setCurrentUsername(String username) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString('username', username);
  }

  Future<String> getCurrentUsername() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString('username');
  }

  Future<void> setUserUID(String uid) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString('uid', uid);
  }

  Future<String> getUserUID() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString('uid');
  }

  Future<void> setLanguage(String lang) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString('lang', lang);
  }

  Future<String> getLanguage() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString('lang');
  }

  Future<bool> clearData() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.clear();
  }
}
