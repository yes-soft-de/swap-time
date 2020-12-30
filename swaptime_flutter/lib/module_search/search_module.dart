import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/abstracts/module/yes_module.dart';
import 'package:swaptime_flutter/module_search/search_routes.dart';
import 'package:swaptime_flutter/module_search/ui/search_screen/search_screen.dart';

@provide
class SearchModule extends YesModule {
  final SearchScreen _searchScreen;
  SearchModule(this._searchScreen);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {SearchRoutes.ROUTE_SEARCH: (context) => _searchScreen};
  }
}
