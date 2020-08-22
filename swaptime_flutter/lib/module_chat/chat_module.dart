import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/abstracts/module/yes_module.dart';
import 'package:swaptime_flutter/utils/auth_guard/auth_gard.dart';

import 'chat_routes.dart';
import 'ui/screens/chat_page/chat_page.dart';

@provide
class ChatModule extends YesModule {
  final ChatPage _chatPage;
  final AuthGuard _authGuard;

  ChatModule(this._chatPage, this._authGuard);

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      ChatRoutes.chatRoute: (context) => FutureBuilder(
            future: _authGuard.isLoggedIn(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return _chatPage;
              }

              return Scaffold();
            },
          ),
    };
  }
}
