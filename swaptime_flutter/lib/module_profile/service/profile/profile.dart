import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/interaction_module/service/liked_service/liked_service.dart';
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
  final GamesListService _gamesListService;
  final LikedService _likedService;

  ProfileService(
    this._manager,
    this._preferencesHelper,
    this._authService,
    this._likedService,
    this._gamesListService,
  );

  Future<bool> hasProfile() async {
    String userImage = await _preferencesHelper.getImage();
    return userImage != null;
  }

  Future<ProfileModel> get profile async {
    var username = await _preferencesHelper.getUsername();
    var image = await _preferencesHelper.getImage();
    var story = await _preferencesHelper.getUserStory();
    return ProfileModel(name: username, image: image, story: story);
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
    print('Requesting User Profile With ID: ' + userId);
    var me = await _authService.userID;
    var interactions = await Future.wait([
      this._likedService.getUserLikes(userId),
      this._gamesListService.getViews(userId)
    ]);

    int likes = 0;
    int views = 0;
    int games = 0;

    try {
      likes = interactions[0];
      views = interactions[1];
    } catch (e) {
      print('Empty Games List');
    }

    List<Games> gamesList = await this._gamesListService.getUserGames(userId);
    games = gamesList.length;

    if (userId == me) {
      var myProfile = await profile;
      return ProfileResponse(
        userName: myProfile.name,
        image: myProfile.image,
        story: myProfile.story,
        likes: likes,
        games: games,
        views: views,
      );
    }
    return _manager.getUserProfile(userId);
  }

  Future<ProfileResponse> getMyProfile() async {
    print('Requesting User Profile');
    String uid = await _authService.userID;
    return await getUserProfile(uid);
  }
}
