import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/module_forms/service/by_image_service/by_image_service.dart';
import 'package:swaptime_flutter/module_forms/states/by_image_state/by_image_state.dart';

@provide
class AddByImageStateManager {
  final PublishSubject<ByImageState> _stateSubject = PublishSubject();

  Stream<ByImageState> get stateStream => _stateSubject.stream;

  final ByImageService _byImageService;

  AddByImageStateManager(this._byImageService);

  void upload(String filePath) {
    _byImageService.upload(filePath).then((value) {
      if (value == null) {
        _stateSubject.add(ByImageStateUploadError('Error Uploading Image!'));
      } else {
        _stateSubject.add(ByImageStateUploadSuccess(value));
      }
    });
  }

  void saveGame(
      String title, String description, List<String> tags, String imageUrl) {
    _byImageService
        .postProduct(title, description, tags, imageUrl)
        .then((value) {
      if (value == null) {
        _stateSubject.add(ByImageStatePostError('Error Saving Product'));
      } else {
        _stateSubject.add(ByImageStatePostSuccess());
      }
    });
  }
}
