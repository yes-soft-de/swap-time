import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class SharedPreferencesHelper {

  Future<void> setCurrentUsername(String username) async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('username', username);
  }

  Future<String> getCurrentUsername() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString('username');
  }

  Future<void> setUserUID(String uid) async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('uid', uid);
  }

  Future<String> getUserUID() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString('uid');
  }

  Future<bool> clearData() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.clear();
  }

  Future<void> setLoggedInState(LoggedInState state) async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString("loggedInState", state.toString());
  }

  Future<LoggedInState> getLoggedInState() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    String loggedInState = _sharedPreferences.getString('loggedInState');
    if (loggedInState == null)
      return LoggedInState.NOT_LOGGED_ID;
    if (loggedInState == LoggedInState.NOT_LOGGED_ID.toString())
      return LoggedInState.NOT_LOGGED_ID;
    if (loggedInState == LoggedInState.TOURISTS.toString())
      return LoggedInState.TOURISTS;
    if (loggedInState == LoggedInState.GUIDE.toString())
      return LoggedInState.GUIDE;
    return LoggedInState.NOT_LOGGED_ID;
  }
}

enum LoggedInState {
  NOT_LOGGED_ID,
  TOURISTS,
  GUIDE
}