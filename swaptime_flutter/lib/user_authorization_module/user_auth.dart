import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/abstracts/module/yes_module.dart';

import 'ui/screens/create_profile/create_profile.dart';
import 'ui/screens/intention_profile/intention_profile.dart';
import 'ui/screens/login/login.dart';
import 'ui/screens/register/register.dart';
import 'user_auth_routes.dart';

@provide
class UserAuthorizationModule extends YesModule {
  LoginScreen _loginScreen;
  RegisterScreen _registerScreen;
  CreateProfileScreen _createProfileScreen;
  IntentionProfileScreen _intentionProfileScreen;

  UserAuthorizationModule(this._createProfileScreen, this._registerScreen,
      this._loginScreen, this._intentionProfileScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      UserAuthorizationRoutes.login: (context) => _loginScreen,
      UserAuthorizationRoutes.register: (context) => _registerScreen,
      UserAuthorizationRoutes.createProfile: (context) => _createProfileScreen,
      UserAuthorizationRoutes.createIntentions: (context) =>
          _intentionProfileScreen,
    };
  }
}
