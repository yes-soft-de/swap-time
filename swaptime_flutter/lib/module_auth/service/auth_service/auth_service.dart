import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';
import 'package:swaptime_flutter/module_auth/enums/auth_source.dart';
import 'package:swaptime_flutter/module_auth/manager/auth/auth_manager.dart';
import 'package:swaptime_flutter/module_auth/presistance/auth_prefs_helper.dart';
import 'package:swaptime_flutter/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:swaptime_flutter/utils/logger/logger.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final FireNotificationService _fireNotificationService;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final PublishSubject _authSubject = PublishSubject();
  Stream get onAuthorized => _authSubject.stream;

  AuthService(
    this._prefsHelper,
    this._authManager,
    this._fireNotificationService,
  );

  Future<bool> loginUser(
    String uid,
    String name,
    String email,
    AUTH_SOURCE authSource,
  ) async {
    try {
      await _authManager.createUser(uid);
    } catch (e) {
      Logger().info('AuthService', 'User Already Exists');
    }

    String token = await _authManager.getToken(uid, uid);

    if (token == null) {
      return false;
    }

    await Future.wait([
      _prefsHelper.setUserId(uid),
      _prefsHelper.setUsername(name),
      _prefsHelper.setAuthSource(authSource),
      _prefsHelper.setToken(token),
    ]);

    await _fireNotificationService.refreshNotificationToken(token);
    return true;
  }

  Future<String> getToken() async {
    try {
      bool isLoggedIn = await this.isLoggedIn;
      var tokenDate = await this._prefsHelper.getTokenDate();
      var diff = DateTime.now().difference(DateTime.parse(tokenDate)).inMinutes;
      if (isLoggedIn) {
        if (diff < 0) {
          diff = diff * -1;
        }
        if (diff < 55) {
          return _prefsHelper.getToken();
        }
        await refreshToken();
        return _prefsHelper.getToken();
      }
    } catch (e) {
      return null;
    }
    return null;
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
