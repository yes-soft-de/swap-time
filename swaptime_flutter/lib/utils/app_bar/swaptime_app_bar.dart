import 'package:flutter/material.dart';

class SwaptimeAppBar {
  static AppBar getSwaptimeAppBar(GlobalKey<ScaffoldState> drawerKey) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu,
        ),
        onPressed: () {
          drawerKey.currentState.openDrawer();
        },
      ),
      title: Text(
        'Swaptime',
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      centerTitle: true,
      actions: [],
    );
  }

  static AppBar getBackEnabledAppBar() {
    return AppBar(
      title: Text(
        'Swaptime',
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      centerTitle: true,
      actions: [
        // IconButton(
        //   icon: Icon(Icons.search),
        //   onPressed: () {
        //     // TODO Move to Search Page
        //   },
        // )
      ],
    );
  }
}
