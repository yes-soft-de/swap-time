import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/auth_module/states/auth_states/auth_states.dart';

@provide
class AuthStateManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final PublishSubject<AuthState> _stateSubject = PublishSubject();

  Stream<AuthState> get stateStream => _stateSubject.stream;

  String _verificationId;

  void SignInWithPhone(String phone) {
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credentials) {
          _auth.signInWithCredential(credentials).then((value) {
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
        codeAutoRetrievalTimeout: null);
  }

  void confirmWithCode(String code) {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: code);

    _auth.signInWithCredential(credential).then((value) {
      _stateSubject.add(AuthStateSuccess());
    }).catchError((err) {
      _stateSubject.add(AuthStateError(err));
    });
  }
}
