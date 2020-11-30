import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/manager/games_manager/games_manager.dart';
import 'package:swaptime_flutter/games_module/response/games_response/games_response.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:swaptime_flutter/module_profile/response/profile_response/profile_response.dart';
import 'package:swaptime_flutter/module_report/service/report_service/report_service.dart';

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

    for (int i = 0; i < allGamesList.length; i++) {
      var reported =
          await _reportService.isReported(allGamesList[i].id.toString());
      if (reported == true) {
        print('game is reported');
        continue;
      }
      visibleGames.add(allGamesList[i]);
    }
    return visibleGames;
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
    List<Games> games = await getAvailableGames;
    if (games == null) {
      return null;
    }
    Games theGame;
    for (int i = 0; i < games.length; i++) {
      if (games[i].id == gameId) {
        theGame = games[i];
      }
    }

    for (int i = 0; i < theGame.comments.length; i++) {
      String userId = theGame.comments[i].userID;
      ProfileResponse profile = await _profileManager.getUserProfile(userId);
      theGame.comments[i].profile = profile;
    }

    await recordView(theGame.userID);

    return theGame;
  }

  Future<void> recordView(String userId) async {
    FirebaseFirestore store = FirebaseFirestore.instance;
    print('Viewing ' + userId);
    if (userId != null) {
      try {
        await store
            .collection('user_interactions')
            .doc('views')
            .collection(userId)
            .add({'msg': 'Hello'});
      } catch (e) {
        print(e);
      }
    }
  }

  Future<int> getViews(String userId) async {
    print('Requesting views');
    FirebaseFirestore store = FirebaseFirestore.instance;

    try {
      var result = await store
          .collection('user_interactions')
          .doc('views')
          .collection(userId)
          .get();
      print('Got ${result.size} views');
      return result.size;
    } catch (e) {
      return 0;
    }
  }

  List<Games> _shrinkList(List<Games> originalList) {
    Map<int, Games> gamesMap = {};
    originalList.forEach((element) {
      gamesMap[element.id] = element;
    });
    return List.from(gamesMap.values);
  }
}
