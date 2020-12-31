import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/games_routes.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/interaction_module/response/liked_games/liked_games.dart';
import 'package:swaptime_flutter/interaction_module/state_manager/liked_manager/liked_state_manager.dart';
import 'package:swaptime_flutter/interaction_module/states/liked_states.dart';
import 'package:swaptime_flutter/interaction_module/ui/widget/liked_item/liked_item.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_profile/profile_routes.dart';
import 'package:swaptime_flutter/module_profile/service/profile/profile.dart';

@provide
class LikedScreen extends StatefulWidget {
  final LikedStateManager _stateManager;
  final ProfileService _profileService;
  final AuthService _authService;

  LikedScreen(
    this._stateManager,
    this._authService,
    this._profileService,
  );

  @override
  State<StatefulWidget> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  LikedState currentState;
  bool initiated = false;

  @override
  void initState() {
    super.initState();
    widget._authService.isLoggedIn.then((authorized) {
      if (authorized == false || authorized == null) {
        Navigator.of(context).pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
        return;
      }
      widget._profileService.hasProfile().then((value) {
        if (value == false || value == null) {
          Navigator.of(context).pushNamed(ProfileRoutes.MY_ROUTE_PROFILE);
          return;
        }
        setState(() {});
      });
    });

    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initiated) {
      initiated = true;
      widget._stateManager.getLikedGames();
    }
    return getCurrentUI();
  }

  Widget getCurrentUI() {
    switch (currentState.runtimeType) {
      case LikedStateLoadSuccess:
        return getSuccessUI();
      case LikedStateLoadError:
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

  Widget getSuccessUI() {
    LikedStateLoadSuccess state = currentState;
    List<Widget> likedGames = [];

    if (_processGames(state.games).isEmpty) {
      return Center(child: Text(S.of(context).emptyList));
    }

    _processGames(state.games).forEach((element) {
      likedGames.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            GamesRoutes.ROUTE_GAME_DETAILS,
            arguments: element.swapItemID,
          );
        },
        child: LikedItemCard(
          gameImageUrl: element.mainImage,
          ownerFirstName: ' ',
          onHate: () {
            widget._stateManager.onHate('${element.id}');
          },
          onGo: () {
            Navigator.of(context).pushNamed(
              GamesRoutes.ROUTE_GAME_DETAILS,
              arguments: element.id,
            );
          },
          date: element.date == null
              ? ' '
              : DateTime.fromMillisecondsSinceEpoch(
                      element.date.timestamp * 1000)
                  .toString()
                  .substring(0, 10),
        ),
      ));
    });

    return Flex(
      direction: Axis.vertical,
      children: likedGames,
    );
  }

  Widget getErrorUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(S.of(context).errorLoadingItems),
        OutlineButton(
            child: Text(S.of(context).retry),
            onPressed: () {
              widget._stateManager.getLikedGames();
            })
      ],
    );
  }

  List<LikedGameItem> _processGames(List<LikedGameItem> gamesList) {
    Map<int, LikedGameItem> gamesMap = {};
    gamesList.forEach((element) {
      gamesMap[element.swapItemID] = element;
    });

    return List.of(gamesMap.values);
  }
}
