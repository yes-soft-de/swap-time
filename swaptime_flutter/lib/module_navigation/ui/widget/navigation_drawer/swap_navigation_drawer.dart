import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';
import 'package:swaptime_flutter/module_profile/model/profile_model/profile_model.dart';
import 'package:swaptime_flutter/module_profile/service/profile/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class SwapNavigationDrawer extends StatelessWidget {
  final ProfileService profileService;

  SwapNavigationDrawer(this.profileService);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 252,
      child: Stack(
        children: [
          // Background
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.softLight,
            ),
          ),

          Positioned.fill(
              child: Container(
            color: Colors.black54,
          )),

          // Foreground
          Positioned.fill(
              child: Container(
            color: Color(0x882CC0CD),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // region Header
                FutureBuilder(
                  future: profileService.hasProfile(),
                  initialData: false,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (!snapshot.hasData || !snapshot.data) {
                      return Container();
                    }
                    return Container(
                      height: 116,
                      color: Color(0x8FFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // User Image
                            Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // User Details
                            Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                  future: profileService.profile,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<ProfileModel> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text(S.of(context).loading);
                                    }
                                    return Text('${snapshot.data.name}');
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // endregion

                // region Sections
                Flex(
                  direction: Axis.vertical,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(HomeRoutes.ROUTE_HOME, arguments: 0);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.dashboard,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(
                              S.of(context).feed,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          HomeRoutes.ROUTE_HOME,
                          arguments: 1,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(S.of(context).notifications,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(HomeRoutes.ROUTE_HOME, arguments: 4);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(S.of(context).settings,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(S.of(context).tos,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        canLaunch('https://www.google.com').then((value) {
                          launch('https://www.google.com');
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            Container(
                              width: 16,
                            ),
                            Text(
                              S.of(context).privacyPolicy,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // endregion

                // region Social Links
                Container(
                  height: 36,
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          canLaunch('https://www.google.com').then((value) {
                            launch('https://www.google.com');
                          });
                        },
                        child: SvgPicture.asset('asset/images/twitter.svg'),
                      ),
                      GestureDetector(
                        onTap: () {
                          canLaunch('https://www.google.com').then((value) {
                            launch('https://www.google.com');
                          });
                        },
                        child: SvgPicture.asset(
                          'assets/images/facebook.svg',
                        ),
                      ),
                    ],
                  ),
                ),
                // endregion

                // region Feedback Button
                GestureDetector(
                  onTap: () {
                    canLaunch('https://www.google.com').then((value) {
                      if (value) {
                        launch('https://www.google.com');
                      }
                    });
                  },
                  child: Container(
                    width: 252,
                    height: 48,
                    alignment: Alignment.center,
                    color: Color(0xFFFFFFFF),
                    child: Text(S.of(context).feedback),
                  ),
                ),
                // endregion
              ],
            ),
          ))
        ],
      ),
    );
  }
}
