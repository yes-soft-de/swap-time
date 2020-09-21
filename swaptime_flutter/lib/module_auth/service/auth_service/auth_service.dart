import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/enums/auth_source.dart';
import 'package:swaptime_flutter/module_auth/presistance/auth_prefs_helper.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthService(this._prefsHelper);

  Future<void> loginUser(
      String uid, String name, AUTH_SOURCE authSource) async {
    await _prefsHelper.setUserId(uid);
    await _prefsHelper.setUsername(name);
    await _prefsHelper.setAuthSource(authSource);
  }

  Future<bool> get isLoggedIn => _prefsHelper.isSignedIn();

  Future<String> get userID => _prefsHelper.getUserId();

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _prefsHelper.clearPrefs();
  }
}
