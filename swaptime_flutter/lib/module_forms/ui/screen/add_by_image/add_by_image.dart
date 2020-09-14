import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_forms/state_manager/add_by_image_manager/add_by_image_manager.dart';
import 'package:swaptime_flutter/module_forms/states/by_image_state/by_image_state.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';
import 'package:swaptime_flutter/module_navigation/ui/widget/navigation_drawer/swap_navigation_drawer.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

@provide
class AddByImageScreen extends StatefulWidget {
  final AddByImageStateManager _stateManager;

  AddByImageScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => _AddByImageScreenState();
}

class _AddByImageScreenState extends State<AddByImageScreen> {
  final Set _tagList = {};
  final TextEditingController _gameName = TextEditingController();
  final TextEditingController _tagName = TextEditingController();

  String filePath;

  GlobalKey<ScaffoldState> _scaffoldKey;
  Scaffold currentPage;

  @override
  void initState() {
    super.initState();
    _listenToChanges();
  }

  @override
  Widget build(BuildContext context) {
    filePath = ModalRoute.of(context).settings.arguments;
    if (currentPage == null) {
      _getInitUI();
    }
    return currentPage;
  }

  void _listenToChanges() {
    widget._stateManager.stateStream.listen((event) {
      _calcCurrentState(event);
    });
  }

  void _calcCurrentState(ByImageState newState) {
    switch (newState.runtimeType) {
      case ByImageStateUploadSuccess:
        ByImageStateUploadSuccess successState = newState;
        _getUploadSuccessUI(successState.imageUrl);
        break;
      case ByImageStateUploadError:
        ByImageStateUploadError errState = newState;
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(errState.errorMsg)));
        break;
      case ByImageStatePostError:
        ByImageStatePostError errState = newState;
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(errState.errorMsg)));
        break;
      case ByImageStatePostSuccess:
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeRoutes.ROUTE_HOME, (route) => false,
            arguments: 1);
        break;
      default:
        _getInitUI();
        break;
    }
  }

  void _getInitUI() {
    currentPage = Scaffold(
      key: _scaffoldKey,
      appBar: SwaptimeAppBar.getSwaptimeAppBar(_scaffoldKey),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            flex: 1,
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
                              child: Text('Upload Image'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                            Container(
                              decoration: BoxDecoration(
                                color: SwapThemeData.getPrimary(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90)),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: _tagName.text.isEmpty
                                    ? null
                                    : () {
                                        _tagList.add(_tagName.text);
                                        setState(() {});
                                      },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black12,
                        child: _getTagChips().isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  children: _getTagChips(),
                                ),
                              )
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Tag List Here'),
                                  )
                                ],
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
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
                Container(
                  alignment: Alignment.center,
                  color: SwapThemeData.getPrimary(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Submit Game!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _getUploadSuccessUI(String imageUrl) {
    currentPage = Scaffold(
      appBar: SwaptimeAppBar.getSwaptimeAppBar(_scaffoldKey),
      drawer: SwapNavigationDrawer(),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            flex: 1,
            child: Stack(
              children: [
                Positioned.fill(child: Image.network(imageUrl)),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _gameName,
                          decoration: InputDecoration(
                            hintText: 'GTA V',
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _tagName,
                                decoration: InputDecoration(
                                  hintText: 'Tags',
                                  labelText: 'Racing',
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
                            Container(
                              decoration: BoxDecoration(
                                color: SwapThemeData.getPrimary(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90)),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: _tagName.text.isEmpty
                                    ? null
                                    : () {
                                        _tagList.add(_tagName.text);
                                        setState(() {});
                                      },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black12,
                        child: _getTagChips().isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  children: _getTagChips(),
                                ),
                              )
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Tag List Here'),
                                  )
                                ],
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
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
                Container(
                  alignment: Alignment.center,
                  color: SwapThemeData.getPrimary(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Submit Game!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    if(mounted) setState(() {});
  }

  List<Widget> _getTagChips() {
    List<Widget> chips = [];
    _tagList.forEach((element) {
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
}
