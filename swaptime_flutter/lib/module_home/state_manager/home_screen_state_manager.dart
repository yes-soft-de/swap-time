import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class HomeStateManager {
  final PublishSubject _stateSubject = PublishSubject();
  Stream get stateStream => _stateSubject.stream;

  void getSwapMarket() {
  }

  void dispose() {
    _stateSubject.close();
  }
}