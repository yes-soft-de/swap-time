import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class MyProfileStateManager {
  final PublishSubject _stateSubject = PublishSubject();
  Stream get stateStream => _stateSubject.stream;

  void getMyProfile() {}
}
