import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/camera/camer_routes.dart';
import 'package:swaptime_flutter/module_profile/profile_routes.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

@provide
class MyProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  String imageUrl;
  bool updateComplete = false;

  @override
  Widget build(BuildContext context) {
    imageUrl = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: SwaptimeAppBar.getBackEnabledAppBar(),
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          imageUrl == null
              ? Container(
                  height: 256,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Container(
                              height: 256,
                              width: double.infinity,
                              child: SvgPicture.asset(
                                'assets/images/logo.svg',
                                fit: BoxFit.cover,
                              ))),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: SwapThemeData.getPrimary(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Add Image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Stack(
                  children: [
                    Image.network(imageUrl),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            CameraRoutes.ROUTE_CAMERA,
                            arguments: ProfileRoutes.MY_ROUTE_PROFILE,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.camera_alt),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(),
          ),
          Container(
            decoration: BoxDecoration(color: SwapThemeData.getAccent()),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Save Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
