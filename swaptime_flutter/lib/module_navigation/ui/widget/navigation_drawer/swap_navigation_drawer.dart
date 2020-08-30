import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwapNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 252,
      color: Color(0xFF2CC0CD),
      child: Stack(
        children: [
          // Background
//          Image.asset(
//            'assets/images/logo.png',
//            fit: BoxFit.cover,
//          ),

          // For ground
          Positioned.fill(
              child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // region Header
              Container(
                height: 116,
                color: Color(0x8FFFFFFF),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    // User Image
                    Container(
                      height: 56,
                      width: 56,
                    ),
                    // User Details
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        Text('User Name'),
                        Text('Phone Number'),
                      ],
                    )
                  ],
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
                        Text('Message', style: TextStyle(color: Colors.white)),
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
                        Text('Settings', style: TextStyle(color: Colors.white)),
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
                color: Color(0x8FFFFFFF),
                child: Text('Feedback!'),
              )
              // endregion
            ],
          ))
        ],
      ),
    );
  }
}
