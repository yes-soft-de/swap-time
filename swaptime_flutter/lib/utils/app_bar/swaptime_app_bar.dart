import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';

class SwaptimeAppBar {
  static AppBar getSwaptimeAppBar(
      GlobalKey<ScaffoldState> drawerKey, Function() onSearchRequested) {
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
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            onSearchRequested();
          },
        )
      ],
    );
  }

  static AppBar getBackEnabledAppBar() {
    return AppBar(
      title: Text(
        'Swaptime',
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      centerTitle: true,
    );
  }

  static AppBar getSearchAppBar(
      BuildContext context, Function(String) onSearchRequested) {
    TextEditingController controller = TextEditingController();
    return AppBar(
      leading: IconButton(
        color: Theme.of(context).brightness != Brightness.light
            ? Colors.black
            : Colors.white,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          onSearchRequested(null);
        },
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.black87
          : Colors.white,
      title: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: S.of(context).search,
            labelText: S.of(context).search,
            hintStyle: TextStyle(
              color: Theme.of(context).brightness != Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            labelStyle: TextStyle(
              color: Theme.of(context).brightness != Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            fillColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () {
            onSearchRequested(controller.text.trim());
          },
        )
      ],
    );
  }
}
