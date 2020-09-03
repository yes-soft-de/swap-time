import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list/game_card_list.dart';
import 'package:swaptime_flutter/liked_module/ui/liked_screen/liked_screen.dart';
import 'package:swaptime_flutter/module_navigation/ui/widget/navigation_drawer/swap_navigation_drawer.dart';
import 'package:swaptime_flutter/module_notifications/ui/screens/notification_screen/notification_screen.dart';
import 'package:swaptime_flutter/module_profile/ui/profile_screen/profile_screen.dart';
import 'package:swaptime_flutter/module_settings/ui/ui/settings_page/settings_page.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int currentPage = 0;
  final PageController pagesController = PageController(initialPage: 0);

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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _drawerKey.currentState.openDrawer();
            },
          ),
          title: Text(
            'Swaptime',
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // TODO Move to Search Page
              },
            )
          ],
        ),
        drawer: SwapNavigationDrawer(),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(90)),
              color: SwapThemeData.getAccent()),
          child: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: Move to Add Item
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
          child: bodyPages,
        ));
  }
}
