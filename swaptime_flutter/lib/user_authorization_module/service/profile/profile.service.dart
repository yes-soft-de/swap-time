import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_persistence/sharedpref/shared_preferences_helper.dart';
import 'package:swaptime_flutter/user_authorization_module/manager/profile/profile.manager.dart';
import 'package:swaptime_flutter/user_authorization_module/request/create_profile/create_profile_body.dart';
import 'package:swaptime_flutter/user_authorization_module/response/create_profile/create_profile_response.dart';

@provide
class ProfileService {
  ProfileManager _profileManager;
  SharedPreferencesHelper _preferencesHelper;

  ProfileService(this._profileManager, this._preferencesHelper);

  Future<CreateProfileResponse> createProfile(CreateProfileBody profile) async {
    // Get UID
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser();
    String uid = user.uid;

    if (uid == null) {
      log('Error, Null UID!');
      return null;
    }

    // Assign UID to the request
    profile.userID = uid;

    // Bye Bye, Sending Request
    CreateProfileResponse createProfileResponse =
        await this._profileManager.createProfile(profile);

    if (createProfileResponse != null) {
      // Cache Result
      this
          ._preferencesHelper
          .setCurrentUsername(createProfileResponse.profileData.name);

      return createProfileResponse;
    }

    return null;
  }
}
