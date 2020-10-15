import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_forms/navigation_args/by_api_args/by_api_args.dart';
import 'package:swaptime_flutter/module_forms/service/rawg_service/rawg_service.dart';
import 'package:swaptime_flutter/module_forms/state_manager/add_by_image_manager/add_by_image_manager.dart';
import 'package:swaptime_flutter/module_forms/states/by_image_state/by_image_state.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

@provide
class AddByImageScreen extends StatefulWidget {
  final AddByImageStateManager _stateManager;

  AddByImageScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => _AddByImageScreenState();
}

class _AddByImageScreenState extends State<AddByImageScreen> {
  final Set<String> _tagList = {};

  final TextEditingController _gameName = TextEditingController();
  final TextEditingController _descriptionName = TextEditingController();
  final TextEditingController _tagName = TextEditingController();

  String filePath;
  String imageUrl;

  Widget currentPage;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  GamePlatform _gamePlatform;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      _calcCurrentState(event);
    });

    _tagList.clear();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    if (args is String) {
      filePath = args;
    } else if (args is ByApiArgs) {
      imageUrl = args.imageUrl;
      _gameName.text = args.gameName;
      if (args.gamePlatform != null) {
        _gamePlatform = args.gamePlatform;
      } else {
        _gamePlatform = GamePlatform.PC;
      }
    }
    if (currentPage == null) {
      _getUI();
    }
    return Scaffold(
        appBar: SwaptimeAppBar.getBackEnabledAppBar(),
        key: _scaffoldState,
        body: _getUI());
  }

  void _calcCurrentState(ByImageState newState) {
    switch (newState.runtimeType) {
      case ByImageStateUploadSuccess:
        ByImageStateUploadSuccess successState = newState;
        imageUrl = successState.imageUrl;
        if (mounted) setState(() {});
        break;
      case ByImageStateUploadError:
        ByImageStateUploadError errState = newState;
        _scaffoldState.currentState
            .showSnackBar(SnackBar(content: Text(errState.errorMsg)));
        break;
      case ByImageStatePostError:
        ByImageStatePostError errState = newState;
        _scaffoldState.currentState
            .showSnackBar(SnackBar(content: Text(errState.errorMsg)));
        break;
      case ByImageStatePostSuccess:
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeRoutes.ROUTE_HOME, (route) => false,
            arguments: 1);
        break;
      default:
        if (mounted) setState(() {});
        break;
    }
  }

  Widget _getUI() {
    return Flex(
      direction: Axis.vertical,
      children: [
        MediaQuery.of(context).viewInsets.bottom == 0
            ? _getImage()
            : Container(),
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _gameName,
                  decoration: InputDecoration(
                    hintText: 'i.e. GTA V',
                    labelText: 'Game Name',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(
                        0xFF7F7F7F,
                      ),
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              DropdownButton(
                hint: Text(S.of(context).platform),
                value: _gamePlatform ?? GamePlatform.PS4,
                onChanged: (value) {
                  _gamePlatform = value;
                },
                items: [
                  DropdownMenuItem(
                    value: GamePlatform.SWITCH,
                    child: Text(GamePlatform.SWITCH.toString().split('.')[1]),
                  ),
                  DropdownMenuItem(
                    value: GamePlatform.PC,
                    child: Text(GamePlatform.PC.toString().split('.')[1]),
                  ),
                  DropdownMenuItem(
                    value: GamePlatform.PS3,
                    child: Text(GamePlatform.PS3.toString().split('.')[1]),
                  ),
                  DropdownMenuItem(
                    value: GamePlatform.PS4,
                    child: Text(GamePlatform.PS4.toString().split('.')[1]),
                  ),
                  DropdownMenuItem(
                    value: GamePlatform.PS5,
                    child: Text(GamePlatform.PS5.toString().split('.')[1]),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _tagName,
                        decoration: InputDecoration(
                          labelText: 'Tags',
                          hintText: 'i.e. Racing',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(
                              0xFF7F7F7F,
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addTagItem();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: SwapThemeDataService.getAccent(),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black12,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: _getTagChips(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionName,
                  decoration: InputDecoration(
                    hintText: 'My game is an awesome game',
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(
                        0xFF7F7F7F,
                      ),
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if (imageUrl == null) {
              Fluttertoast.showToast(msg: S.of(context).pleaseUploadTheImage);
              return;
            }
            widget._stateManager.saveGame(
              _gameName.text,
              _descriptionName.text,
              List.from(_tagList),
              imageUrl,
              _gamePlatform,
            );
          },
          child: Container(
            alignment: Alignment.center,
            color: SwapThemeDataService.getPrimary(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).submitGame,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _getImage() {
    if (imageUrl != null) {
      return Container(
        height: MediaQuery.of(context).size.height / 4,
        child: Stack(
          children: [
            Positioned.fill(child: Image.network(imageUrl)),
          ],
        ),
      );
    } else if (filePath != null) {
      return Container(
        height: MediaQuery.of(context).size.height / 4,
        child: Stack(
          children: [
            Positioned.fill(child: Image.file(File(filePath))),
            Positioned.fill(
                child: Center(
              child: OutlineButton(
                onPressed: () {
                  widget._stateManager.upload(filePath);
                },
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                      color: Colors.black26,
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.upload_file),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(S.of(context).uploadImage),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height / 4,
        child: Stack(
          children: [
            Positioned.fill(child: SvgPicture.asset('assets/images/logo.svg')),
            Positioned.fill(
                child: Center(
              child: OutlineButton(
                onPressed: () {
                  widget._stateManager.upload(filePath);
                },
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                      color: Colors.black26,
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.upload_file),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(S.of(context).uploadImage),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      );
    }
  }

  List<Widget> _getTagChips() {
    if (_tagList.isEmpty) {
      return [Text(S.of(context).emptyTagList)];
    }
    List<Widget> chips = [];
    _tagList.forEach((element) {
      log(element);
      chips.add(Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
        child: Chip(
          label: Text(
            element,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black45,
        ),
      ));
    });
    return chips;
  }

  void addTagItem() {
    _tagList.add(_tagName.text);
    _tagName.clear();
    if (mounted) {
      setState(() {});
    }
  }
}
