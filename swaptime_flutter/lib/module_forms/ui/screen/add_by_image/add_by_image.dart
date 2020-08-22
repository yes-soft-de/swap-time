import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/camera/ui/screen/camera_screen/camera_screen.dart';

@provide
class AddByImageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddByImageScreenState();
}

class _AddByImageScreenState extends State<AddByImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraScreen(),
    );
  }
}
