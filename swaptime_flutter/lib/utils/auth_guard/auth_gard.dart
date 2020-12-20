import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
@singleton
class AuthGuard {
  final SharedPreferencesHelper _sharedPreferencesHelper;

  AuthGuard(this._sharedPreferencesHelper);

  Future<bool> isLoggedIn() async {
    var user = _sharedPreferencesHelper.getUserUID();
    return user != null;
  }
}
