import 'dart:async';

import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaptime_flutter/games_module/service/games_list_service/games_list_service.dart';
import 'package:swaptime_flutter/games_module/states/game_details_state/game_details_state.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_comment/service/comment_service/comment_service.dart';
import 'package:swaptime_flutter/module_profile/service/profile/profile.dart';
import 'package:swaptime_flutter/module_report/service/report_service/report_service.dart';

@provide
class GameDetailsManager {
  final PublishSubject _stateSubject = PublishSubject();

  Stream get stateStream => _stateSubject.stream;

  final GamesListService _gamesListService;
  final ReportService _reportService;
  final CommentService _commentService;
  final ProfileService _profileService;
  final AuthService _authService;

  StreamSubscription _commentsListener;

  GameDetailsManager(
    this._gamesListService,
    this._reportService,
    this._commentService,
    this._profileService,
    this._authService,
  );

  void getGameDetails(int gameId) {
    // Get initial
    Future.wait(
            [_gamesListService.getGameDetails(gameId), _authService.isLoggedIn])
        .then((value) {
      if (value == null) {
        _stateSubject.add(GameDetailsStateLoadError());
      } else {
        _stateSubject.add(GameDetailsStateLoadSuccess(value[0], value[1]));
        initListenting(gameId, value[1]);
      }
    });
  }

  void initListenting(int gameId, bool isLoggedIn) {
    // Update when needed
    _commentsListener =
        _commentService.onCommentChangeWatcher(gameId).listen((event) {
      _gamesListService.getGameDetails(gameId).then((value) {
        if (value == null) {
          _stateSubject.add(GameDetailsStateLoadError());
        } else {
          _stateSubject.add(GameDetailsStateLoadSuccess(value, isLoggedIn));
        }
      });
    });
  }

  void postComment(int gameId, commentMsg) {
    _profileService.getMyProfile().then((profile) {
      _commentService.postComment(gameId, commentMsg).then((value) {
        getGameDetails(gameId);
      });
    });
  }

  void reportGame(String gameId) {
    _reportService.reportGame(gameId);
  }

  void dispose() {
    _commentsListener.cancel();
  }
}
