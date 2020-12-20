import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/enums/auth_source.dart';
import 'package:swaptime_flutter/module_auth/manager/auth/auth_manager.dart';
import 'package:swaptime_flutter/module_auth/presistance/auth_prefs_helper.dart';
import 'package:swaptime_flutter/utils/logger/logger.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthManager _authManager;
  AuthService(this._prefsHelper, this._authManager);

  Future<bool> loginUser(
      String uid, String name, String email, AUTH_SOURCE authSource) async {
    try {
      await _authManager.createUser(uid);
    } catch (e) {
      Logger().info('AuthService', 'User Already Exists');
    }

    String token = await _authManager.getToken(uid, uid);

    if (token == null) {
      return false;
    }
    await _prefsHelper.setUserId(uid);
    await _prefsHelper.setUsername(name);
    await _prefsHelper.setAuthSource(authSource);
    await _prefsHelper.setToken(token);
    return true;
  }

  Future<String> getToken() async {
    String token = await _prefsHelper.getToken();

    if (token == null) {
      bool isLoggedIn = await this.isLoggedIn;
      if (isLoggedIn) {
        await refreshToken();
        return _prefsHelper.getToken();
      }
    }

    return token;
  }

  Future<void> refreshToken() async {
    String uid = await _prefsHelper.getUserId();
    String token = await _authManager.getToken(uid, uid);
    await _prefsHelper.setToken(token);
  }

  Future<bool> get isLoggedIn => _prefsHelper.isSignedIn();
  Future<String> get userID => _prefsHelper.getUserId();

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _prefsHelper.clearPrefs();
  }
}
