import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/user_authorization_module/request/create_profile/create_profile_body.dart';
import 'package:swaptime_flutter/user_authorization_module/service/profile/profile.service.dart';

@provide
class CreateProfileBloc {
  ProfileService _profileService;
  final _profileCreationSubject = PublishSubject<bool>();

  CreateProfileBloc(this._profileService);
  Stream<bool> get profileStatus => _profileCreationSubject.stream;

  createProfile(String name, String gender, String language) async {
    CreateProfileBody profile =
        new CreateProfileBody(name: name, sex: gender, guideLanguage: language);

    var profileCreated = await this._profileService.createProfile(profile);

    if (profileCreated == null) {
      _profileCreationSubject.add(false);
    }

    _profileCreationSubject.add(true);
  }

  dispose() {
    _profileCreationSubject.close();
  }
}
