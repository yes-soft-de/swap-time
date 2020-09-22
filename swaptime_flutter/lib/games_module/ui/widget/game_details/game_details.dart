import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/state_manager/game_details_state_manager/game_details_list_manager.dart';
import 'package:swaptime_flutter/games_module/states/game_details_state/game_details_state.dart';
import 'package:swaptime_flutter/module_comment/ui/widget/comments_list_widget/comment_list_widget.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

@provide
class GameDetailsScreen extends StatefulWidget {
  final GameDetailsManager _manager;
  final CommentListWidget _commentListWidget;
  final SwapService _swapService;

  GameDetailsScreen(this._manager, this._commentListWidget, this._swapService);

  @override
  State<StatefulWidget> createState() => GameDetailsScreenState();
}

class GameDetailsScreenState extends State<GameDetailsScreen> {
  GameDetailsState currentState;
  String gameId;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool swapRequested = false;

  @override
  void initState() {
    super.initState();
    widget._manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    gameId = ModalRoute.of(context).settings.arguments;
    if (currentState == null) {
      widget._manager.getGameDetails(gameId);
    }
    if (gameId == null) {
      return Scaffold(
        appBar: SwaptimeAppBar.getBackEnabledAppBar(),
        body: Center(
          child: Text('Error Getting Swap Item id!'),
        ),
      );
    }

    return Scaffold(
      appBar: SwaptimeAppBar.getBackEnabledAppBar(),
      body: calibrateScreen(),
    );
  }

  Widget calibrateScreen() {
    switch (currentState.runtimeType) {
      case GameDetailsStateLoadSuccess:
        return getSuccessUI();
      case GameDetailsStateLoadError:
        return getErrorUI();
      default:
        return getLoadingUI();
    }
  }

  Widget getLoadingUI() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget getErrorUI() {
    return Center(
      child: Column(
        children: [
          Text('Error Loading Data'),
          RaisedButton(
            child: Text('Retry'),
            onPressed: () {
              widget._manager.getGameDetails(gameId);
            },
          )
        ],
      ),
    );
  }

  Widget getSuccessUI() {
    GameDetailsStateLoadSuccess state = currentState;
    List<Chip> tagsChips = [];
    state.details.tag.forEach((element) {
      tagsChips.add(Chip(
        label: Text(element),
      ));
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(state.details.mainImage ??
              'https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/256x256/link_broken.png'),
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
                    FutureBuilder(
                      future: widget._swapService.isRequested(gameId),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return GestureDetector(
                            onTap: () {
                              widget._swapService
                                  .createSwap(state.details.userID, gameId);
                              swapRequested = true;
                              setState(() {});
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
                                  )),
                            ),
                          );
                        }
                        if (!snapshot.data) {
                          return GestureDetector(
                            onTap: () {
                              widget._swapService
                                  .createSwap(state.details.userID, gameId);
                              swapRequested = true;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: snapshot.data != true
                                    ? Colors.white
                                    : SwapThemeData.getPrimary(),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: swapRequested
                                    ? Text(
                                        'Request a Swap!',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Icon(
                                        Icons.check,
                                        color: SwapThemeData.getAccent(),
                                      ),
                              ),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            widget._swapService
                                .createSwap(state.details.userID, gameId);
                            swapRequested = true;
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: snapshot.data != true
                                  ? Colors.white
                                  : SwapThemeData.getPrimary(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: !swapRequested
                                  ? Text(
                                      'Request a Swap!',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Icon(
                                      Icons.check,
                                      color: SwapThemeData.getAccent(),
                                    ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Container(
                  height: 32,
                ),
                // Product Details
                Text(
                  'Product Details:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(state.details.name),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(state.details.description),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 32,
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
          Container(
              width: MediaQuery.of(context).size.width,
              child: widget._commentListWidget),
        ],
      ),
    );
  }
}
