import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/module_profile/service/profile/profile.dart';
import 'package:swaptime_flutter/module_profile/state/my_profile_state.dart';
import 'package:swaptime_flutter/module_upload/service/image_upload/image_upload_service.dart';

@provide
class MyProfileStateManager {
  final PublishSubject<MyProfileState> _stateSubject = PublishSubject();

  Stream<MyProfileState> get stateStream => _stateSubject.stream;

  final ImageUploadService _uploadService;
  final ProfileService _myProfileService;

  MyProfileStateManager(this._uploadService, this._myProfileService);

  void setMyProfile(String username, String about, String image) {
    _myProfileService.createProfile(username, image, about).then((value) {
      if (value == null) {
        _stateSubject
            .add(MyProfileStateUpdateError('Error Submitting Profile'));
      } else {
        _stateSubject.add(MyProfileStateUpdateSuccess());
      }
    });
  }

  void getMyProfile() {
    this._myProfileService.getMyProfile().then((value) {
      if (value != null) {
        this._stateSubject.add(MyProfileStateGetSuccess(value));
      } else {
        this._stateSubject.add(null);
      }
    });
  }

  void upload(String imagePath) {
    this._uploadService.uploadImage(imagePath).then((value) {
      if (value == null) {
        _stateSubject
            .add(MyProfileStateUpdateError('Error Submitting Profile'));
      } else {
        _stateSubject.add(MyProfileStateImageUploadSuccess(value));
      }
    });
  }
}
