import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:swaptime_flutter/module_profile/model/profile_model/profile_model.dart';
import 'package:swaptime_flutter/module_profile/presistance/profile_shared_preferences.dart';
import 'package:swaptime_flutter/module_profile/request/create_profile.dart';
import 'package:swaptime_flutter/module_profile/response/profile_response/profile_response.dart';
import 'package:swaptime_flutter/module_profile/service/general_profile/general_profile.dart';

@provide
class MyProfileService {
  final MyProfileManager _manager;
  final ProfileSharedPreferencesHelper _preferencesHelper;
  final AuthService _authService;
  final GeneralProfileService _generalProfileService;

  MyProfileService(
    this._manager,
    this._preferencesHelper,
    this._authService,
    this._generalProfileService,
  );

  Future<bool> hasProfile() async {
    String userImage = await _preferencesHelper.getImage();
    return userImage != null;
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
    await _preferencesHelper.setUserName(response.data.userName);
    await _preferencesHelper.setUserImage(response.data.image);
    await _preferencesHelper.setUserLocation(response.data.location);
    await _preferencesHelper.setUserStory(response.data.story);
    await _generalProfileService.setUserProfile(
        userId,
        ProfileModel(
          name: response.data.userName,
          image: response.data.image,
        ));
    return response;
  }
}
