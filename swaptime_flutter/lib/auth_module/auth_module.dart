import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/abstracts/module/yes_module.dart';
import 'package:swaptime_flutter/auth_module/auth_routes.dart';
import 'package:swaptime_flutter/auth_module/ui/screen/auth_screen/auth_screen.dart';

@provide
class AuthModule extends YesModule {
  final AuthScreen _authScreen;
  AuthModule(this._authScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {AuthRoutes.ROUTE_AUTHORIZE: (context) => _authScreen};
  }
}
