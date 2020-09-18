import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swaptime_flutter/games_module/state_manager/game_details_state_manager/game_details_list_manager.dart';
import 'package:swaptime_flutter/games_module/states/game_details_state/game_details_state.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

class GameDetailsScreen extends StatefulWidget {
  final GameDetailsManager _manager;

  GameDetailsScreen(this._manager);

  @override
  State<StatefulWidget> createState() => GameDetailsScreenState();
}

class GameDetailsScreenState extends State<GameDetailsScreen> {
  Widget currentUI;
  GameDetailsState currentState;

  @override
  void initState() {
    super.initState();
    widget._manager.stateStream.listen((event) {
      currentState = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentUI;
  }

  void calibrateScreen() {}

  void setSuccessUI() {
    GameDetailsStateLoadSuccess state = currentState;
    List<Chip> tagsChips = [];
    state.details.tag.forEach((element) {
      tagsChips.add(Chip(
        label: Text(element),
      ));
    });

    List<Widget> comments = [];
    state.details.comments.forEach((element) {
      comments.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: SwapThemeData.getAccent(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Text(element))
        ],
      ));
    });

    Flex commentSection = Flex(
      direction: Axis.vertical,
      children: comments,
    );

    currentUI = Scaffold(
      appBar: SwaptimeAppBar.getBackEnabledAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(state.details.mainImage),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 8, 16, 8),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.details.name,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: Request a Swap
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: SwapThemeData.getPrimary(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Request a Swap!',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // Product Details
                  Text(
                    'Product Details:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(state.details.name),
                      ),
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(state.details.description),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black26,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: tagsChips,
                ),
              ),
            ),
            commentSection,
          ],
        ),
      ),
    );
  }
}
