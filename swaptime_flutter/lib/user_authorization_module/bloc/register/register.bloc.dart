import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/user_authorization_module/service/register/register.service.dart';

@provide
class RegisterBloc {
  RegisterService _registerService;

  RegisterBloc(this._registerService);

  final _registerChecker = PublishSubject<String>();

  Stream<String> get registerStatus => _registerChecker.stream;

  register(String username, String password) async {
    String loginResponse = await _registerService.register(username, password);

    _registerChecker.add(loginResponse);
  }

  dispose() {
    _registerChecker.close();
  }
}
