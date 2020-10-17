import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:swaptime_flutter/module_profile/model/profile_model/profile_model.dart';
import 'package:swaptime_flutter/module_profile/presistance/profile_shared_preferences.dart';
import 'package:swaptime_flutter/module_profile/request/create_profile.dart';
import 'package:swaptime_flutter/module_profile/response/profile_response/profile_response.dart';

@provide
class ProfileService {
  final MyProfileManager _manager;
  final ProfileSharedPreferencesHelper _preferencesHelper;
  final AuthService _authService;

  ProfileService(this._manager, this._preferencesHelper, this._authService);

  Future<bool> hasProfile() async {
    String userImage = await _preferencesHelper.getImage();
    return userImage != null;
  }

  Future<ProfileModel> get profile async {
    var username = await _preferencesHelper.getUsername();
    var image = await _preferencesHelper.getImage();
    return ProfileModel(name: username, image: image);
  }

  Future<ProfileResponse> createProfile(
    String username,
    String userImage,
    String story,
  ) async {
    String userId = await _authService.userID;

    CreateProfileRequest request = CreateProfileRequest(
        userName: username,
        image: userImage,
        location: 'Saudi Arabia',
        story: story,
        userID: userId);

    ProfileResponse response = await _manager.createMyProfile(request);
    if (response == null) return null;
    await _preferencesHelper.setUserName(response.userName);
    await _preferencesHelper.setUserImage(response.image);
    await _preferencesHelper.setUserLocation(response.location);
    await _preferencesHelper.setUserStory(response.story);
    return response;
  }

  Future<ProfileResponse> getUserProfile(String userId) async {
    var me = await _authService.userID;

    if (userId == me) {
      var myProfile = await profile;
      return ProfileResponse(userName: myProfile.name, image: myProfile.image);
    }

    return _manager.getUserProfile(userId);
  }
}
