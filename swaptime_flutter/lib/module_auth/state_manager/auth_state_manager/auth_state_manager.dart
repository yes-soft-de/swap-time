import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:swaptime_flutter/module_auth/enums/auth_source.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_auth/states/auth_states/auth_states.dart';

@provide
class AuthStateManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService;

  AuthStateManager(this._authService);

  final PublishSubject<AuthState> _stateSubject = PublishSubject();

  Stream<AuthState> get stateStream => _stateSubject.stream;

  String _verificationId;

  void SignInWithPhone(String phone) {
    _auth
        .verifyPhoneNumber(
            phoneNumber: phone,
            verificationCompleted: (credentials) {
              _auth.signInWithCredential(credentials).then((value) async {
                await _authService.loginUser(
                  _auth.currentUser.uid,
                  _auth.currentUser.displayName,
                  null,
                  AUTH_SOURCE.PHONE,
                );
                _stateSubject.add(AuthStateSuccess());
              }).catchError((err) {
                _stateSubject.add(AuthStateError(err));
              });
            },
            verificationFailed: (err) {
              Fluttertoast.showToast(msg: err.message);
            },
            codeSent: (String verificationId, int forceResendingToken) {
              verificationId = verificationId;
              _stateSubject.add(AuthStateCodeSent());
            },
            codeAutoRetrievalTimeout: (verificationId) {
              _verificationId = verificationId;
            })
        .catchError((err) {
      _stateSubject.add(AuthStateError(err.toString()));
    });
  }

  Future<void> authWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      ).signIn();
      print('Got Google User');
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      var result = await FirebaseAuth.instance.signInWithCredential(credential);
      await _loginUser(result);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithApple() async {
    var oauthCred = await _createAppleOAuthCred();
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(oauthCred);
    await _loginUser(result);
  }

  Future<void> _loginUser(UserCredential result) async {
    if (result != null) {
      bool loginSuccess = await _authService.loginUser(
        result.user.uid,
        result.user.displayName,
        result.user.email,
        AUTH_SOURCE.APPLE,
      );
      if (loginSuccess) {
        _stateSubject.add(AuthStateSuccess());
      }
    }
    _stateSubject.add(AuthStateError('Can\'t Sign in!'));
  }

  void confirmWithCode(String code) {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: code,
    );

    _auth.signInWithCredential(credential).then((result) async {
      await _loginUser(result);
    });
  }

  Future<OAuthCredential> _createAppleOAuthCred() async {
    final nonce = _createNonce(32);
    final nativeAppleCred = Platform.isIOS
        ? await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            nonce: sha256.convert(utf8.encode(nonce)).toString(),
          )
        : await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            webAuthenticationOptions: WebAuthenticationOptions(
              redirectUri: Uri.parse(
                  'https://your-project-name.firebaseapp.com/__/auth/handler'),
              clientId: 'your.app.bundle.name',
            ),
            nonce: sha256.convert(utf8.encode(nonce)).toString(),
          );

    return new OAuthCredential(
      providerId: 'apple.com',
      // MUST be "apple.com"
      signInMethod: 'oauth',
      // MUST be "oauth"
      accessToken: nativeAppleCred.identityToken,
      // propagate Apple ID token to BOTH accessToken and idToken parameters
      idToken: nativeAppleCred.identityToken,
      rawNonce: nonce,
    );
  }

  String _createNonce(int length) {
    final random = Random();
    final charCodes = List<int>.generate(length, (_) {
      int codeUnit;

      switch (random.nextInt(3)) {
        case 0:
          codeUnit = random.nextInt(10) + 48;
          break;
        case 1:
          codeUnit = random.nextInt(26) + 65;
          break;
        case 2:
          codeUnit = random.nextInt(26) + 97;
          break;
      }

      return codeUnit;
    });

    return String.fromCharCodes(charCodes);
  }

  Future<bool> isSignedIn() async {
    return _authService.isLoggedIn;
  }
}
