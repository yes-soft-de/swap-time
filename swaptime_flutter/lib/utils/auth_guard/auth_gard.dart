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
    return true;
  }

}
