import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/camera/camer_routes.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list/game_card_list.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/interaction_module/ui/liked_screen/liked_screen.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_forms/forms_routes.dart';
import 'package:swaptime_flutter/module_forms/ui/screen/add_by_api/add_by_api.dart';
import 'package:swaptime_flutter/module_navigation/ui/widget/navigation_drawer/swap_navigation_drawer.dart';
import 'package:swaptime_flutter/module_notifications/ui/screens/notification_screen/notification_screen.dart';
import 'package:swaptime_flutter/module_profile/profile_routes.dart';
import 'package:swaptime_flutter/module_profile/service/profile/profile.dart';
import 'package:swaptime_flutter/module_profile/ui/profile_screen/profile_screen.dart';
import 'package:swaptime_flutter/module_settings/ui/ui/settings_page/settings_page.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

@provide
class HomeScreen extends StatefulWidget {
  final AuthService _auth;
  final ProfileService _myProfileService;
  final GameCardList _gameCardList;
  final ProfileScreen _profileScreen;
  final SettingsPage _settingsPage;
  final LikedScreen _likedScreen;
  final NotificationScreen _notificationScreen;
  final AddByApiScreen _addByApiScreen;

  HomeScreen(
    this._auth,
    this._myProfileService,
    this._gameCardList,
    this._addByApiScreen,
    this._likedScreen,
    this._settingsPage,
    this._notificationScreen,
    this._profileScreen,
  );

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int currentPage = 0;

  bool overlayOpened = false;
  bool initiated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!initiated) {
      var args = ModalRoute.of(context).settings.arguments;

      if (args != null) {
        currentPage = args;
      }
      initiated = true;
    }

    var bodyPages = <Widget>[
      Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              widget._gameCardList,
            ],
          )),
        ],
      ),
      Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              widget._notificationScreen,
            ],
          )),
        ],
      ),
      Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              widget._likedScreen,
            ],
          )),
        ],
      ),
      Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: widget._profileScreen,
          )),
        ],
      ),
      Column(
        children: [
          Expanded(
            child: widget._settingsPage,
          )
        ],
      )
    ];

    return Scaffold(
        key: _drawerKey,
        appBar: SwaptimeAppBar.getSwaptimeAppBar(_drawerKey),
        drawer: SwapNavigationDrawer(widget._myProfileService),
        floatingActionButton: _getFAB(),
        bottomNavigationBar: _getBottomNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
          child: Stack(
            children: [
              bodyPages[currentPage],
              overlayOpened
                  ? Positioned.fill(
                      child: GestureDetector(
                      onTap: () {
                        overlayOpened = false;
                        setState(() {});
                      },
                      child: Container(
                        color: Colors.black12,
                      ),
                    ))
                  : Container(),
            ],
          ),
        ));
  }

  Widget _getBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      currentIndex: currentPage,
      onTap: (index) {
        currentPage = index;
        if (mounted) setState(() {});
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          backgroundColor: SwapThemeDataService.getAccent(),
          title: Text(S.of(context).home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          backgroundColor: SwapThemeDataService.getAccent(),
          title: Text(S.of(context).notifications),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          backgroundColor: SwapThemeDataService.getAccent(),
          title: Text(S.of(context).favorite),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          backgroundColor: SwapThemeDataService.getAccent(),
          title: Text(S.of(context).profile),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          backgroundColor: SwapThemeDataService.getAccent(),
          title: Text(S.of(context).settings),
        ),
      ],
    );
  }

  Widget _getFAB() {
    if (overlayOpened) {
      return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.black26,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context).insertViaCamera,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  color: SwapThemeDataService.getPrimary(),
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                ),
                child: IconButton(
                  color: Colors.blue,
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CameraRoutes.ROUTE_CAMERA,
                      arguments: FormsRoutes.ROUTE_ADD_BY_IMAGE,
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            height: 8,
          ),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.black26,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context).insertViaAPreset,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  color: SwapThemeDataService.getPrimary(),
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                ),
                child: IconButton(
                  color: Colors.blue,
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: widget._addByApiScreen,
                            ));
                  },
                ),
              ),
            ],
          )
        ],
      );
    } else {
      return Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: SwapThemeDataService.getAccent(),
              borderRadius: BorderRadius.all(Radius.circular(90)),
            ),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                widget._auth.isLoggedIn.then((isLoggedIn) async {
                  if (isLoggedIn) {
                    var hasProfile =
                        await widget._myProfileService.hasProfile();
                    if (hasProfile) {
                      overlayOpened = true;
                      setState(() {});
                    } else {
                      await Navigator.of(context)
                          .pushNamed(ProfileRoutes.MY_ROUTE_PROFILE);
                    }
                  } else {
                    await Navigator.of(context)
                        .pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
                  }
                });
              },
            ),
          ),
        ],
      );
    }
  }
}
