import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_persistence/sharedpref/shared_preferences_helper.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

@provide
class LoginService {
  SharedPreferencesHelper _preferencesHelper;

  LoginService(this._preferencesHelper);

  Future<String> login(String username, String password) async {
    // Login User to Firebase
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: username, password: password);

      if (user.user.uid != null) {
        _cacheLoggedInUser(user.user);
        return user.user.uid;
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Can\'t Find user or Error Connecting to Server');
      log(e.toString());
      return null;
    }
  }

  _cacheLoggedInUser(FirebaseUser user) {
    _preferencesHelper.setUserUID(user.uid);
  }
}
