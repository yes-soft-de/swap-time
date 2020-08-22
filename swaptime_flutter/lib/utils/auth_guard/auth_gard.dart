import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_persistence/sharedpref/shared_preferences_helper.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

@provide
@singleton
class AuthGuard {
  SharedPreferencesHelper _sharedPreferencesHelper;

  AuthGuard(this._sharedPreferencesHelper);

  Future<bool> isLoggedIn() async {
    LoggedInState state = await _sharedPreferencesHelper.getLoggedInState();

    if (state == null) {
      return false;
    }

    log('Auth Guard' + state.toString());

    if (state == LoggedInState.NOT_LOGGED_ID) {
      return false;
    }

    if (state == LoggedInState.GUIDE || state == LoggedInState.TOURISTS) {
      return true;
    }

    return state != null;
  }

  Future<bool> isGuide() async {
    LoggedInState state = await _sharedPreferencesHelper.getLoggedInState();

    if (state == null) {
      return false;
    }

    return state == LoggedInState.GUIDE;
  }
}
