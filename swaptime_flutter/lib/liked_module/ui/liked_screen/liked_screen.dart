import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/games_routes.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/liked_module/state_manager/liked_manager/liked_state_manager.dart';
import 'package:swaptime_flutter/liked_module/states/liked_states.dart';
import 'package:swaptime_flutter/liked_module/ui/widget/liked_item/liked_item.dart';
import 'package:swaptime_flutter/module_profile/model/profile_model/profile_model.dart';
import 'package:swaptime_flutter/module_profile/service/general_profile/general_profile.dart';

@provide
class LikedScreen extends StatefulWidget {
  final LikedStateManager _stateManager;
  final GeneralProfileService _generalProfileService;

  LikedScreen(this._stateManager, this._generalProfileService);

  @override
  State<StatefulWidget> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  LikedState currentState;

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!(currentState is LikedStateLoadSuccess)) {
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

    if (state.games.isEmpty) {
      return Center(child: Text(S.of(context).emptyList));
    }

    state.games.forEach((element) {
      likedGames.add(FutureBuilder(
        future: widget._generalProfileService.getUserDetails(element.userID),
        builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(GamesRoutes.ROUTE_GAME_DETAILS,
                    arguments: element.id.toString());
              },
              child: LikedItemCard(
                gameImageUrl: element.mainImage,
                ownerFirstName: snapshot.data.name,
                ownerImageUrl: snapshot.data.image,
              ),
            );
          } else {
            return Container();
          }
        },
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
}
