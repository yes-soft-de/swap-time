import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/abstracts/module/yes_module.dart';
import 'package:swaptime_flutter/module_forms/forms_routes.dart';
import 'package:swaptime_flutter/module_forms/ui/screen/add_by_image/add_by_image.dart';

@provide
class FormsModule extends YesModule {
  final AddByImageScreen _addByImageScreen;

  FormsModule(this._addByImageScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      FormsRoutes.ROUTE_ADD_BY_API: (context) => Container(),
      FormsRoutes.ROUTE_ADD_BY_IMAGE: (context) => _addByImageScreen
    };
  }
}
