import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list/game_card_list.dart';
import 'package:swaptime_flutter/module_navigation/ui/widget/navigation_drawer/swap_navigation_drawer.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var bodyPages = PageView(
      children: [GameCardList()],
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
          padding: const EdgeInsets.all(8.0),
          child: bodyPages,
        ));
  }
}
