import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';
import 'package:swaptime_flutter/module_profile/request/create_profile.dart';
import 'package:swaptime_flutter/module_profile/response/profile_response/profile_response.dart';

@provide
class MyProfileRepository {
  final ApiClient _apiClient;
  MyProfileRepository(this._apiClient);

  Future<ProfileResponse> getMyProfile() async {
    Map<String, dynamic> response = await _apiClient.get(Urls.API_PROFILE);

    return response ?? ProfileResponse.fromJson(response);
  }

  Future<ProfileResponse> createMyProfile(
      CreateProfileRequest profileRequest) async {
    Map<String, dynamic> response =
        await _apiClient.post(Urls.API_PROFILE, profileRequest.toJson());

    return response == null ? null : ProfileResponse.fromJson(response);
  }
}
