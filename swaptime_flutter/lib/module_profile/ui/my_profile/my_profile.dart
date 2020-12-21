import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/consts/urls.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';
import 'package:swaptime_flutter/module_profile/state/my_profile_state.dart';
import 'package:swaptime_flutter/module_profile/state_manager/my_profile/my_profile_state_manager.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

@provide
class MyProfileScreen extends StatefulWidget {
  final MyProfileStateManager _stateManager;

  MyProfileScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  String imageUrl;
  String imageLocation;
  bool uploading = false;
  bool submittingProfile = false;
  final picker = ImagePicker();
  MyProfileState currentState = MyProfileStateLoading();

  bool searchActive = false;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    widget._stateManager.getMyProfile();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      uploading = false;
      processEvent();
      setState(() {});
    });
  }

  void processEvent() {
    if (currentState is MyProfileStateGetSuccess) {
      MyProfileStateGetSuccess state = currentState;
      // If not edit mode, redirect
      if (editMode != true) {
        Navigator.of(context).pushNamed(HomeRoutes.ROUTE_HOME);
      } else {
        _nameController.text = state.profile.userName;
        imageUrl = state.profile.image;
        _aboutController.text = state.profile.story;
        print('User Image $imageUrl');
        if (mounted) setState(() {});
      }
    } else if (currentState is MyProfileStateImageUploadSuccess) {
      MyProfileStateImageUploadSuccess state = currentState;
      imageUrl = state.imageUrl;
      if (mounted) setState(() {});
    } else if (currentState is MyProfileStateUpdateSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeRoutes.ROUTE_HOME,
          (route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments == true) {
      editMode = true;
    }
    return Scaffold(
      appBar: SwaptimeAppBar.getBackEnabledAppBar(),
      body: getUI(),
    );
  }

  Widget getUI() {
    if (currentState is MyProfileStateLoading) {
      return Center(
        child: Flex(
          direction: Axis.vertical,
          children: [
            LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(S.of(context).requestingProfileDateFromTheServer),
            ),
          ],
        ),
      );
    }
    if (imageUrl != null) {
      // My old profile is here!!
      return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Container(
                  height: 256,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Image.network(
                        imageUrl.contains('http') ? imageUrl : Urls.IMAGES_ROOT + imageUrl,
                        fit: BoxFit.cover,
                      )),
                      Positioned(
                        right: 16,
                        top: 16,
                        child: GestureDetector(
                          onTap: () {
                            picker
                                .getImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 70)
                                .then((image) {
                              print('Got image response');
                              if (image != null) {
                                imageLocation = image.path;
                                imageUrl = null;
                                print(image.path);
                                setState(() {});
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: SwapThemeDataService.getPrimary(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: S.of(context).myName,
                hintText: S.of(context).myName,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _aboutController,
              decoration: InputDecoration(
                labelText: S.of(context).aboutMe,
                hintText: S.of(context).aboutMe,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              saveProfile();
            },
            child: GestureDetector(
              onTap: () {
                saveProfile();
              },
              child: Container(
                decoration:
                    BoxDecoration(color: SwapThemeDataService.getAccent()),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        !submittingProfile
                            ? S.of(context).saveProfile
                            : S.of(context).saving,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }
    if (imageLocation == null) {
      // Take My Picture
      return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Stack(
              children: [
                // BG
                Positioned.fill(
                    child: Container(
                        height: 256,
                        width: double.infinity,
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',
                          fit: BoxFit.cover,
                        ))),
                // Buttons
                Positioned.fill(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: SwapThemeDataService.getPrimary(),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            picker
                                .getImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 70)
                                .then((image) {
                              if (image != null) {
                                imageLocation = image.path;
                                print(image.path);
                                setState(() {});
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              S.of(context).selectMyImageFromGallery,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          color: SwapThemeDataService.getPrimary(),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            picker
                                .getImage(
                                    source: ImageSource.camera,
                                    imageQuality: 70)
                                .then((image) {
                              print('Got image response');
                              if (image != null) {
                                imageLocation = image.path;
                                print(image.path);
                                setState(() {});
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              S.of(context).captureMyImageWithTheCamera,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration:
                  BoxDecoration(color: SwapThemeDataService.getAccent()),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).captureMyPicture,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    } else if (imageLocation != null && imageUrl == null) {
      // Upload My Picture
      return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    File(imageLocation),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            picker
                                .getImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 70)
                                .then((image) {
                              print('Got image response');
                              if (image != null) {
                                imageLocation = image.path;
                                print(image.path);
                                setState(() {});
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: SwapThemeDataService.getPrimary(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            picker
                                .getImage(
                                    source: ImageSource.camera,
                                    imageQuality: 70)
                                .then((image) {
                              print('Got image response');
                              if (image != null) {
                                imageLocation = image.path;
                                print(image.path);
                                setState(() {});
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: SwapThemeDataService.getPrimary(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                    child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        color: SwapThemeDataService.getPrimary(),
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: GestureDetector(
                      onTap: () {
                        uploading = true;
                        setState(() {});
                        widget._stateManager.upload(imageLocation);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          uploading != true
                              ? S.of(context).uploadMe
                              : S.of(context).uploading,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              widget._stateManager.upload(imageLocation);
            },
            child: Container(
              decoration:
                  BoxDecoration(color: SwapThemeDataService.getAccent()),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      uploading != true
                          ? S.of(context).uploadMe
                          : S.of(context).uploading,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    } else {
      // Save the Full Profile
      return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Container(
                  height: 256,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Image.network(
                        imageUrl.contains('http')
                            ? imageUrl
                            : Urls.IMAGES_ROOT + imageUrl,
                        fit: BoxFit.cover,
                      )),
                      Positioned(
                        right: 16,
                        top: 16,
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () {
                                picker
                                    .getImage(
                                        source: ImageSource.camera,
                                        imageQuality: 70)
                                    .then((image) {
                                  if (image != null) {
                                    imageLocation = image.path;
                                    imageUrl = null;
                                    setState(() {});
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: SwapThemeDataService.getPrimary(),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                picker
                                    .getImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 70)
                                    .then((image) {
                                  if (image != null) {
                                    imageLocation = image.path;
                                    imageUrl = null;
                                    setState(() {});
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: SwapThemeDataService.getPrimary(),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: S.of(context).myName,
                hintText: S.of(context).myName,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _aboutController,
              decoration: InputDecoration(
                labelText: S.of(context).aboutMe,
                hintText: S.of(context).aboutMe,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              saveProfile();
            },
            child: GestureDetector(
              onTap: () {
                saveProfile();
              },
              child: Container(
                decoration:
                    BoxDecoration(color: SwapThemeDataService.getAccent()),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        !submittingProfile
                            ? S.of(context).saveProfile
                            : S.of(context).saving,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }
  }

  void saveProfile() {
    if (imageUrl == null) {
      Fluttertoast.showToast(msg: S.of(context).pleaseUploadYourImage);
      return;
    }
    if (_nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseEnterYourName);
      return;
    }
    if (_aboutController.text.isEmpty) {
      Fluttertoast.showToast(msg: S.of(context).pleaseEnterAShortStoryAboutYou);
      return;
    }
    submittingProfile = true;
    setState(() {});
    widget._stateManager.setMyProfile(
      _nameController.text.trim(),
      _aboutController.text.trim(),
      imageUrl.contains('http')
          ? imageUrl.substring(Urls.IMAGES_ROOT.length)
          : imageUrl,
    );
  }
}
