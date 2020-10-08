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
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

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

  void authWithGoogle() {
    _googleSignIn.signIn().then((value) {
      _authService.loginUser(value.id, value.displayName, AUTH_SOURCE.GOOGLE);
    });
  }

  void authWithApple() {
    SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.aboutyou.dart_packages.sign_in_with_apple.example',
        redirectUri: Uri.parse(
          'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
        ),
      ),
    );
  }

  void confirmWithCode(String code) {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: code);

    _auth.signInWithCredential(credential).then((value) async {
      await _authService.loginUser(
        _auth.currentUser.uid,
        _auth.currentUser.displayName,
        AUTH_SOURCE.PHONE,
      );
      _stateSubject.add(AuthStateSuccess());
    }).catchError((err) {
      _stateSubject.add(AuthStateError(err));
    });
  }

  Future<bool> isSignedIn() async {
    var user = await _auth.currentUser;
    return user != null;
  }
}
