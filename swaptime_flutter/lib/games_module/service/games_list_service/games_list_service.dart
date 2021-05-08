import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/manager/games_manager/games_manager.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:swaptime_flutter/module_report/service/report_service/report_service.dart';
import 'package:swaptime_flutter/utils/logger/logger.dart';

@provide
class GamesListService {
  final GamesManager _manager;
  final AuthService _authService;
  final MyProfileManager _profileManager;
  final ReportService _reportService;

  GamesListService(
    this._manager,
    this._authService,
    this._profileManager,
    this._reportService,
  );

  Future<List<Games>> get getAvailableGames async {
    List<Games> allGamesList = await _manager.getAvailableGames;
    allGamesList = _shrinkList(allGamesList);
    var visibleGames = <Games>[];

    if (allGamesList != null) {
      for (int i = 0; i < allGamesList.length; i++) {
        var reported = await _reportService.isReported(
          allGamesList[i].id.toString(),
        );
        if (reported == true) {
          continue;
        }
        visibleGames.add(allGamesList[i]);
      }
    }
    return visibleGames.reversed.toList();
  }

  Future<List<Games>> getUserGames(String userId) async {
    Map<int, Games> games = <int, Games>{};
    var allGames = await getAvailableGames;
    if (allGames == null) return null;
    allGames.forEach((element) {
      if (element.userID == userId) {
        games[element.id] = element;
      }
    });

    return games.values.toList();
  }

  Future<List<Games>> getMyGames() async {
    var userId = await _authService.userID;
    var games = <Games>[];
    var allGames = await getAvailableGames;
    allGames.forEach((element) {
      if (element.userID == userId) {
        games.add(element);
      }
    });

    return games;
  }

  Future<Games> getGameDetails(int gameId) async {
    if (gameId == -1) {
      return null;
    }
    Games theGame = await _manager.getGameById(gameId);
    try {
      recordView(theGame.userID);
    } catch(e) {
      print(e);
    }

    return theGame;
  }

  void recordView(String userId) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    if (userId != null) {
      try {
        store
            .collection('user_interactions')
            .doc('views')
            .collection(userId)
            .add({'msg': 'Hello'});
      } catch (e) {
        Logger().error('GamesListService', e.toString());
      }
      return;
    }
  }

  Future<int> getViews(String userId) async {
    FirebaseFirestore store = FirebaseFirestore.instance;

    try {
      var result = await store
          .collection('user_interactions')
          .doc('views')
          .collection(userId)
          .get();
      return result.size;
    } catch (e) {
      return 0;
    }
  }

  List<Games> _shrinkList(List<Games> originalList) {
    if (originalList == null) {
      return null;
    }
    Map<int, Games> gamesMap = {};
    originalList.forEach((element) {
      gamesMap[element.id] = element;
    });
    return List.from(gamesMap.values);
  }
}
