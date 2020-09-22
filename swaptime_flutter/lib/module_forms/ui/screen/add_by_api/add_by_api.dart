import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_forms/forms_routes.dart';
import 'package:swaptime_flutter/module_forms/model/search_model/search_model.dart';
import 'package:swaptime_flutter/module_forms/navigation_args/by_api_args/by_api_args.dart';
import 'package:swaptime_flutter/module_forms/service/rawg_service/rawg_service.dart';
import 'package:swaptime_flutter/module_forms/state_manager/add_by_api_manager/add_by_api_manager.dart';
import 'package:swaptime_flutter/module_forms/ui/widget/search_card/search_card.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';

@provide
class AddByApiScreen extends StatefulWidget {
  final AddByApiStateManager _stateManager;

  AddByApiScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => _AddByApiState();
}

class _AddByApiState extends State<AddByApiScreen> {
  final TextEditingController _controller = TextEditingController();
  List<SearchModel> searchResult = [];
  String selectedGameName;
  String selectedGameImage;
  GamePlatform selectedGamePlatform;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      searchResult = event;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 2 / 3,
      child: Container(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'GTA V',
                        labelText: 'Search...',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        searchResult = [];
                        selectedGamePlatform = null;
                        selectedGameImage = null;
                        selectedGameName = null;
                        setState(() {});
                        widget._stateManager.search(_controller.text);
                      }),
                ],
              ),
            ),
            Expanded(
              child: searchResult != null && searchResult.isNotEmpty
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: getSearchResult(),
                    )
                  : Center(
                      child: Text('Search a Game :)'),
                    ),
            ),
            selectedGamePlatform != null
                ? RaisedButton(
                    color: SwapThemeData.getPrimary(),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(FormsRoutes.ROUTE_ADD_BY_IMAGE,
                              arguments: ByApiArgs(
                                selectedGameImage,
                                selectedGameName,
                                selectedGamePlatform,
                              ));
                    },
                    child: Text('Add $selectedGameName to my collection'),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  List<Widget> getSearchResult() {
    var searchResultCards = <Widget>[];
    searchResult.forEach((element) {
      searchResultCards.add(Padding(
        padding: EdgeInsets.all(8),
        child: SearchCard(
          searchModel: element,
          gameActive: element.name == selectedGameName,
          platformActive: selectedGamePlatform,
          onGameSelected: (String name, String image) {
            selectedGameName = name;
            selectedGameImage = image;
            selectedGamePlatform = null;
            setState(() {});
          },
          onPlatformSelected: (platform) {
            selectedGamePlatform = platform;
            setState(() {});
          },
        ),
      ));
    });
    return searchResultCards;
  }
}
