import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_profile/repository/my_profile/my_profile.dart';
import 'package:swaptime_flutter/module_profile/request/create_profile.dart';
import 'package:swaptime_flutter/module_profile/response/profile_response/profile_response.dart';

@provide
class MyProfileManager {
  final MyProfileRepository _repository;
  MyProfileManager(this._repository);

  Future<ProfileResponse> getMyProfile() {
    return _repository.getMyProfile();
  }

  Future<ProfileResponse> createMyProfile(
      CreateProfileRequest createProfileRequest) {
    return _repository.createMyProfile(createProfileRequest);
  }
}
