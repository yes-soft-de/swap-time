import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_persistence/sharedpref/shared_preferences_helper.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

@provide
class RegisterService {
  final SharedPreferencesHelper _sharedPrefsHelper;

  RegisterService(this._sharedPrefsHelper);

  Future<String> register(String username, String password) async {
    log('Register a user with email: ' +
        username +
        ' and Password: ' +
        password);
    try {
      final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

      print('User Registeration: ' + (authResult.user != null).toString());
      AuthResult user = await _auth.signInWithEmailAndPassword(email: username, password: password);

      if (user.user != null) {
        this.cacheLoggedInUser(user.user);
        return user.user.uid;
      } else {
        log('User Registration Failed');
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      log(e.toString());
      return null;
    }
  }

  cacheLoggedInUser(FirebaseUser user) {
    _sharedPrefsHelper.setCurrentUsername(user.email);
    _sharedPrefsHelper.setUserUID(user.uid);
  }
}
