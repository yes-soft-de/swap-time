import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swaptime_flutter/module_chat/chat_routes.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

class NotificationOnGoing extends StatelessWidget {
  final String myGameUrl;
  final String theirGameUrl;
  final String theirName;
  final String chatRoomId;

  NotificationOnGoing({
    this.myGameUrl,
    this.chatRoomId,
    @required this.theirGameUrl,
    @required this.theirName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset.fromDirection(90),
                blurRadius: 8,
                color: Colors.grey),
          ],
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Stack(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Image.network(
                        theirGameUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: myGameUrl != null
                          ? Image.network(theirGameUrl)
                          : Stack(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/logo.svg',
                                  fit: BoxFit.cover,
                                ),
                                Positioned.fill(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              SwapThemeDataService.getAccent(),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          'Request Pending!',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                    )
                  ],
                ),
                myGameUrl != null
                    ? Positioned.fill(
                        child: Center(
                        child: Container(
                          color: SwapThemeDataService.getPrimary(),
                          child: Icon(
                            Icons.repeat,
                            color: Colors.white,
                          ),
                        ),
                      ))
                    : Container()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(90))),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: 16,
                      ),
                      Text(theirName)
                    ],
                  ),
                  IconButton(
                      icon: chatRoomId != null
                          ? Icon(
                              Icons.chat,
                              color: SwapThemeDataService.getPrimary(),
                            )
                          : Icon(
                              Icons.pending_rounded,
                              color: SwapThemeDataService.getPrimary(),
                            ),
                      onPressed: () {
                        if (chatRoomId != null) {
                          Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                              arguments: chatRoomId);
                        } else {
                          Fluttertoast.showToast(msg: 'Pending Approval');
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
