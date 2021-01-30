import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/state_manager/game_details_state_manager/game_details_list_manager.dart';
import 'package:swaptime_flutter/games_module/states/game_details_state/game_details_state.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list/game_card_list.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_comment/model/comment_model/comment_model.dart';
import 'package:swaptime_flutter/module_comment/service/comment_service/comment_service.dart';
import 'package:swaptime_flutter/module_comment/ui/widget/comments_list_widget/comment_list_widget.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';
import 'package:swaptime_flutter/module_profile/service/profile/profile.dart';
import 'package:swaptime_flutter/module_report/ui/widget/report_dialog/report_dialog.dart';
import 'package:swaptime_flutter/module_swap/service/swap_service/swap_service.dart';
import 'package:swaptime_flutter/module_swap/ui/widget/restrict_acceess_dialog/restrict_acceess_dialog.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

@provide
class GameDetailsScreen extends StatefulWidget {
  final GameDetailsManager _manager;
  final SwapService _swapService;
  final CommentService _commentService;
  final AuthService _authService;
  final GameCardList _gameCardList;
  final ProfileService _profileService;
  final RestrictAccessDialog _restrictAccessDialog;

  GameDetailsScreen(
    this._manager,
    this._swapService,
    this._commentService,
    this._authService,
    this._gameCardList,
    this._profileService,
    this._restrictAccessDialog,
  );

  @override
  State<StatefulWidget> createState() => GameDetailsScreenState();
}

class GameDetailsScreenState extends State<GameDetailsScreen> {
  GameDetailsState currentState;
  int gameId;
  bool swapRequested = false;
  bool reported = false;
  bool inited = false;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription _stateSubscription;

  @override
  void initState() {
    super.initState();
    _stateSubscription = widget._manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    if (_stateSubscription != null) {
      currentState = GameDetailsStateInit();
      _stateSubscription.cancel();
    }
    widget._manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!inited){
      inited = true;
      gameId =
          int.tryParse(ModalRoute.of(context).settings.arguments.toString());
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
      key: scaffoldKey,
      appBar: SwaptimeAppBar.getBackEnabledAppBar(
          reported: reported,
          onReport: () {
            showDialog(
                context: context,
                builder: (_) => Dialog(
                      child: ReportDialog(onConfirm: () {
                        widget._manager.reportGame(gameId.toString());
                        showSnackBar(S.of(context).reportingGame);
                        reported = true;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            HomeRoutes.ROUTE_HOME, (route) => false);
                      }, onCancel: () {
                        Navigator.of(context).pop();
                      }),
                    ));
          }),
      body: calibrateScreen(),
    );
  }

  void showSnackBar(String msg) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
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

  Widget getCommentList(List<CommentModel> comments, bool loggedIn) {
    print('Building Comments: ${jsonEncode(comments.last.toJson())}');
    return CommentListWidget(
      commentList: comments,
      isLoggedIn: loggedIn,
      onCommentAdded: (newComment) {
        FocusScope.of(context).unfocus();
        showSnackBar(S.of(context).postingNewComment);
        widget._manager
            .postComment(gameId, newComment);
      },
    );
  }

  Widget getSuccessUI() {
    GameDetailsStateLoadSuccess state = currentState;
    List<Chip> tagsChips = [];
    if (state.details.tag.isNotEmpty) {
      state.details.tag.forEach((element) {
        tagsChips.add(Chip(
          label: Text(element),
        ));
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 256,
            width: MediaQuery.of(context).size.width,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/logo.jpg',
              image: state.details.mainImage,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 8, 16, 8),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      future: widget._authService.userID,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.data == state.details.userID) {
                          return Container();
                        }
                        return state.details.isRequested != true
                            ? GestureDetector(
                                onTap: () {
                                  _requestSwap(state);
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
                              )
                            : Icon(Icons.check);
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
            child: tagsChips.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      children: tagsChips,
                    ),
                  )
                : Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: getCommentList(state.details.comments, state.isLoggedId)),
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

  void _requestSwap(state) {
    var dialog = Dialog(
      child: widget._restrictAccessDialog,
    );
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: dialog,
            ),
          );
        }).then(
      (restrictedGamesList) {
        if (restrictedGamesList == null) {
          return null;
        }
        showSnackBar(S.of(context).requestingASwap);
        widget._swapService
            .createSwap(state.details.userID, gameId, restrictedGamesList)
            .then((value) {
          swapRequested = true;
          state.details.isRequested = true;
          showSnackBar(S.of(context).swapRequestSent);
          setState(() {});
        }).catchError(
          (e) => {
            Navigator.of(context).pushNamed(AuthRoutes.ROUTE_AUTHORIZE),
          },
        );
      },
    );
  }
}
