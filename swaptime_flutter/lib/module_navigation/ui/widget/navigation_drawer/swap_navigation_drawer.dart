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
      alignment: AlignmentDirectional.center,
      child: Stack(
        children: [
          // Background
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              fit: BoxFit.cover,
              color: Colors.black,
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      color: Theme.of(context).brightness != Brightness.light
                          ? Colors.black38
                          : Colors.white38,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // User Image
                            Container(
                              height: 56,
                              width: 56,
                              child: FutureBuilder(
                                future: profileService.profile,
                                builder: (BuildContext context,
                                    AsyncSnapshot<ProfileModel> snapshot) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(snapshot.data.image),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: BoxShape.circle),
                                  );
                                },
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
                                    return Text(
                                      '${snapshot.data.name}',
                                      style: TextStyle(fontSize: 20),
                                    );
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Flex(
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
                ),
                // endregion

                // region Social Links
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          canLaunch('https://www.google.com').then((value) {
                            launch('https://www.google.com');
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/images/twitter.svg',
                            fit: BoxFit.contain,
                            color: Colors.white,
                            height: 36,
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
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/images/facebook.svg',
                            fit: BoxFit.contain,
                            color: Colors.white,
                            height: 36,
                          ),
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
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
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
