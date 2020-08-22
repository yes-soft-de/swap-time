import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/module_network/http_client/http_client.dart';
import 'package:swaptime_flutter/user_authorization_module/request/create_profile/create_profile_body.dart';
import 'package:swaptime_flutter/user_authorization_module/response/create_profile/create_profile_response.dart';

@provide
class IntentionsRepository {
  HttpClient _client;

  IntentionsRepository(this._client);

  Future<CreateProfileResponse> createIntentions(
      CreateProfileBody createProfileBody) async {
    Map response =
        await _client.put(Urls.createProfileAPI, createProfileBody.toJson());
    if (response != null) {
      return CreateProfileResponse.fromJson(response);
    }
    return null;
  }
}
