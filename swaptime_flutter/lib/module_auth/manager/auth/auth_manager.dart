import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/repository/auth/auth_repository.dart';

@provide
class AuthManager {
  final AuthRepository _authRepository;
  AuthManager(this._authRepository);

  Future<bool> createUser(String uid) => _authRepository.createUser(uid);

  Future<String> getToken(String uid, String password) =>
      _authRepository.getToken(uid, password);
}
