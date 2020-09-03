import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SwapNavigationDrawer extends StatelessWidget {
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
              colorBlendMode: BlendMode.screen,
            ),
          ),

          // For ground
          Positioned.fill(
              child: Container(
            color: Color(0x882CC0CD),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // region Header
                Container(
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
                            borderRadius: BorderRadius.all(Radius.circular(90)),
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
                            Text('Osama'),
                            Text('+963 953 691 509'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // endregion

                // region Sections
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Padding(
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
                            'Feed',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Icon(
                            Icons.explore,
                            color: Colors.white,
                          ),
                          Container(
                            width: 16,
                          ),
                          Text(
                            'Explore',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          Container(
                            width: 16,
                          ),
                          Text('Message',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Padding(
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
                          Text('Notifications',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Padding(
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
                          Text('Settings',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 8.0, 0, 8),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          Container(
                            width: 16,
                          ),
                          Text('Search', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Padding(
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
                          Text('TOS', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Padding(
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
                          Text('Privacy Policy',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                // endregion

                // region Social Links
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.face,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.face,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.face,
                      color: Colors.white,
                    ),
                  ],
                ),
                // endregion

                // region Feedback Button
                Container(
                  width: 252,
                  height: 48,
                  alignment: Alignment.center,
                  color: Color(0xFFFFFFFF),
                  child: Text('Feedback!'),
                )
                // endregion
              ],
            ),
          ))
        ],
      ),
    );
  }
}
