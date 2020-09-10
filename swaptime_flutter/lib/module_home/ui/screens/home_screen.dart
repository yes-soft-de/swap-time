import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swaptime_flutter/camera/camer_routes.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list/game_card_list.dart';
import 'package:swaptime_flutter/liked_module/ui/liked_screen/liked_screen.dart';
import 'package:swaptime_flutter/module_forms/forms_routes.dart';
import 'package:swaptime_flutter/module_navigation/ui/widget/navigation_drawer/swap_navigation_drawer.dart';
import 'package:swaptime_flutter/module_notifications/ui/screens/notification_screen/notification_screen.dart';
import 'package:swaptime_flutter/module_profile/ui/profile_screen/profile_screen.dart';
import 'package:swaptime_flutter/module_settings/ui/ui/settings_page/settings_page.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int currentPage = 0;
  final PageController pagesController = PageController(initialPage: 0);

  bool overlayOpened = false;

  @override
  Widget build(BuildContext context) {
    var bodyPages = PageView(
      controller: pagesController,
      onPageChanged: (index) {
        currentPage = index;
        if (mounted) setState(() {});
      },
      children: [
        Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                GameCardList(),
              ],
            )),
          ],
        ),
        Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                NotificationScreen(),
              ],
            )),
          ],
        ),
        Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                LikedScreen(),
              ],
            )),
          ],
        ),
        Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                ProfileScreen(),
              ],
            )),
          ],
        ),
        Column(
          children: [
            Expanded(
              child: SettingsPage(),
            )
          ],
        )
      ],
    );

    return Scaffold(
        key: _drawerKey,
        appBar: SwaptimeAppBar.getSwaptimeAppBar(_drawerKey),
        drawer: SwapNavigationDrawer(),
        floatingActionButton: _getFAB(),
        bottomNavigationBar: _getBottomNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
          child: Stack(
            children: [
              bodyPages,
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
        pagesController.animateToPage(
          currentPage,
          duration: Duration(seconds: 1),
          curve: Curves.easeIn,
        );
        if (mounted) setState(() {});
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          backgroundColor: SwapThemeData.getAccent(),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          backgroundColor: SwapThemeData.getAccent(),
          title: Text('Notifications'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          backgroundColor: SwapThemeData.getAccent(),
          title: Text('Favorite'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          backgroundColor: SwapThemeData.getAccent(),
          title: Text('Profile'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          backgroundColor: SwapThemeData.getAccent(),
          title: Text('Settings'),
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
                    'Insert via Camera',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  color: SwapThemeData.getPrimary(),
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                ),
                child: IconButton(
                  color: Colors.blue,
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CameraRoutes.ROUTE_CAMERA,
                        arguments: FormsRoutes.ROUTE_ADD_BY_IMAGE);
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
                    'Insert via a Preset',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  color: SwapThemeData.getPrimary(),
                  borderRadius: BorderRadius.all(Radius.circular(90)),
                ),
                child: IconButton(
                  color: Colors.blue,
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // TODO: Show Search Dialog
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
              color: SwapThemeData.getAccent(),
              borderRadius: BorderRadius.all(Radius.circular(90)),
            ),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                overlayOpened = true;
                setState(() {});
              },
            ),
          ),
        ],
      );
    }
  }
}
