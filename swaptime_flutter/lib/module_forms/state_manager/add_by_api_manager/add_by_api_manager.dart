import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class AddByApiStateManager {
  final PublishSubject _stateSubject = PublishSubject();
  Stream get stateStream => _stateSubject.stream;

  AddByApiStateManager();

  void search(String query, String platform) async {}
}
