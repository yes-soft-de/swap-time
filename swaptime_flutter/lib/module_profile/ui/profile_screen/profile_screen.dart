import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/games_module/ui/widget/game_card_list/game_card_list.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_profile/presistance/profile_shared_preferences.dart';
import 'package:swaptime_flutter/module_profile/profile_routes.dart';
import 'package:swaptime_flutter/module_profile/service/my_profile/my_profile.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

@provide
class ProfileScreen extends StatefulWidget {
  final GameCardList _cardList;
  final AuthService _authService;
  final MyProfileService _myProfileService;
  final ProfileSharedPreferencesHelper _preferencesHelper;

  ProfileScreen(
    this._cardList,
    this._authService,
    this._myProfileService,
    this._preferencesHelper,
  );

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool hasProfile = false;
  @override
  void initState() {
    super.initState();
    widget._authService.isLoggedIn.then((authorized) {
      if (authorized == false) {
        Navigator.of(context).pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
        return;
      }
      widget._myProfileService.hasProfile().then((value) {
        if (value == false) {
          Navigator.of(context).pushNamed(ProfileRoutes.MY_ROUTE_PROFILE);
          return;
        }
        hasProfile = true;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return getUI(hasProfile);
  }

  Widget getUI(bool hasProfile) {
    if (!hasProfile) {
      return Container();
    } else {
      return Flex(
        direction: Axis.vertical,
        children: [
          Container(
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: FutureBuilder(
                    future: widget._preferencesHelper.getImage(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Image.network(snapshot.data);
                      }
                      return SvgPicture.asset('assets/images/logo.svg');
                    },
                  )),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xF8FFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(90))),
                      child: IconButton(
                        onPressed: () {
                          // TODO: Change Personal Image
                        },
                        icon: Icon(Icons.find_replace),
                      ),
                    ),
                  )
                ],
              )),
          // Flex(
          //   direction: Axis.horizontal,
          //   children: [
          //     Flexible(
          //       flex: 1,
          //       fit: FlexFit.tight,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Container(
          //           height: 96,
          //           color: SwapThemeData.getPrimary(),
          //           child: Padding(
          //             padding: const EdgeInsets.all(16.0),
          //             child: Flex(
          //               direction: Axis.vertical,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   '7',
          //                   style: TextStyle(
          //                     fontSize: 36,
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Text(
          //                   'Likes',
          //                   style: TextStyle(
          //                     fontSize: 18,
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Flexible(
          //       flex: 1,
          //       fit: FlexFit.tight,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Container(
          //           height: 96,
          //           color: SwapThemeData.getPrimary(),
          //           child: Padding(
          //             padding: const EdgeInsets.all(16.0),
          //             child: Flex(
          //               direction: Axis.vertical,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   '7',
          //                   style: TextStyle(
          //                     fontSize: 36,
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Text(
          //                   'Likes',
          //                   style: TextStyle(
          //                     fontSize: 18,
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Flexible(
          //       flex: 1,
          //       fit: FlexFit.tight,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Container(
          //           height: 96,
          //           color: SwapThemeData.getPrimary(),
          //           child: Padding(
          //             padding: const EdgeInsets.all(16.0),
          //             child: Flex(
          //               direction: Axis.vertical,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   '7',
          //                   style: TextStyle(
          //                     fontSize: 36,
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Text(
          //                   'Likes',
          //                   style: TextStyle(
          //                     fontSize: 18,
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: SwapThemeDataService.getPrimary(),
                    child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: FutureBuilder(
                          future: widget._preferencesHelper.getUserStory(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return Text(
                              'Please Add a Story!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        )),
                  ),
                ),
              ),
            ],
          ),
          widget._cardList
        ],
      );
    }
  }
}
