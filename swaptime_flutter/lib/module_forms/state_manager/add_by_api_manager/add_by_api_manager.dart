import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/module_forms/model/search_model/search_model.dart';
import 'package:swaptime_flutter/module_forms/service/rawg_service/rawg_service.dart';

@provide
class AddByApiStateManager {
  final PublishSubject<List<SearchModel>> _stateSubject = PublishSubject();
  Stream<List<SearchModel>> get stateStream => _stateSubject.stream;

  final RawGService _gService;
  AddByApiStateManager(this._gService);

  void search(String query) {
    _gService.search(query).then((value) {
      _stateSubject.add(value);
    });
  }
}
