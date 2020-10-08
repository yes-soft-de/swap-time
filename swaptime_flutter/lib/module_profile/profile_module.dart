import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/abstracts/module/yes_module.dart';
import 'package:swaptime_flutter/module_profile/profile_routes.dart';
import 'package:swaptime_flutter/module_profile/ui/my_profile/my_profile.dart';

@provide
class ProfileModule extends YesModule {
  final MyProfileScreen _myProfileScreen;

  ProfileModule(this._myProfileScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {ProfileRoutes.MY_ROUTE_PROFILE: (context) => _myProfileScreen};
  }
}
