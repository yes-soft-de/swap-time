import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/abstracts/module/yes_module.dart';
import 'package:swaptime_flutter/camera/camer_routes.dart';
import 'package:swaptime_flutter/camera/ui/screen/camera_screen/camera_screen.dart';

@provide
class CameraModule extends YesModule {
  final CameraScreen _cameraScreen;
  CameraModule(this._cameraScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {CameraRoutes.ROUTE_CAMERA: (context) => _cameraScreen};
  }
}
