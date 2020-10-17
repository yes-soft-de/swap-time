import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/state_manager/game_details_state_manager/game_details_list_manager.dart';
import 'package:swaptime_flutter/games_module/states/game_details_state/game_details_state.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list/game_card_list.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_comment/service/comment_service/comment_service.dart';
import 'package:swaptime_flutter/module_comment/ui/widget/comments_list_widget/comment_list_widget.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

@provide
class GameDetailsScreen extends StatefulWidget {
  final GameDetailsManager _manager;
  final SwapService _swapService;
  final CommentService _commentService;
  final AuthService _authService;
  final GameCardList _gameCardList;

  GameDetailsScreen(
    this._manager,
    this._swapService,
    this._commentService,
    this._authService,
    this._gameCardList,
  );

  @override
  State<StatefulWidget> createState() => GameDetailsScreenState();
}

class GameDetailsScreenState extends State<GameDetailsScreen> {
  GameDetailsState currentState;
  int gameId;
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
          child: Text(S.of(context).errorGettingSwapItemId),
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
          Text(S.of(context).errorLoadingData),
          RaisedButton(
            child: Text(S.of(context).retry),
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
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/logo.jpg',
            image: state.details.mainImage.substring(29),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 8, 16, 8),
            child: Flex(
              direction: Axis.vertical,
              children: [
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.details.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: widget._swapService.isRequested(gameId),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.hasData) {
                          print('Is Requested? ' + snapshot.data.toString());
                        }
                        if (snapshot.data != true) {
                          return GestureDetector(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Requesting a swap')));
                              swapRequested = true;
                              widget._swapService
                                  .createSwap(state.details.userID, gameId)
                                  .then((value) {
                                swapRequested = true;
                                setState(() {});
                              }).catchError((e) => {
                                        Navigator.of(context).pushNamed(
                                            AuthRoutes.ROUTE_AUTHORIZE)
                                      });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: SwapThemeDataService.getPrimary(),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    S.of(context).requestASwap,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              widget._swapService.createSwap(
                                state.details.userID,
                                gameId,
                              );
                              swapRequested = true;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.check,
                                  color: SwapThemeDataService.getAccent(),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
                Container(
                  height: 32,
                ),
                // Product Details
                Text(
                  S.of(context).productDetails,
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
                          S.of(context).name,
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
                          S.of(context).description,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: widget._authService.userID,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return CommentListWidget(
                          state.details.comments,
                          (newComment) => {
                            widget._commentService
                                .postComment(gameId, newComment)
                                .then((value) {
                              widget._manager.getGameDetails(gameId);
                            }),
                            snapshot.data
                          },
                          snapshot.data,
                        );
                      }
                    }
                    return CommentListWidget(
                        state.details.comments,
                        (newComment) => {
                              widget._commentService
                                  .postComment(gameId, newComment),
                              snapshot.data
                            });
                  },
                )),
          ),
          Container(
            height: 32,
          ),
          widget._gameCardList,
          Container(
            height: 64,
          )
        ],
      ),
    );
  }
}
