import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_chat/chat_module.dart';
import 'package:swaptime_flutter/module_forms/forms_module.dart';
import 'package:swaptime_flutter/user_authorization_module/user_auth.dart';

import 'di/components/app.component.dart';
import 'generated/l10n.dart';
import 'module_forms/forms_routes.dart';
import 'module_home/home.module.dart';

typedef Provider<T> = T Function();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    final container = await AppComponent.create();
    runApp(container.app);
  });
}

@provide
class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  final HomeModule _homeModule;
  final FormsModule _formsModule;
  final UserAuthorizationModule _userAuthorizationModule;
  final ChatModule _chatModule;

  MyApp(this._homeModule, this._formsModule, this._chatModule,
      this._userAuthorizationModule);

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutesList = {};

    fullRoutesList.addAll(_homeModule.getRoutes());
    fullRoutesList.addAll(_formsModule.getRoutes());
    fullRoutesList.addAll(_userAuthorizationModule.getRoutes());
    fullRoutesList.addAll(_chatModule.getRoutes());

    return MaterialApp(
        navigatorObservers: <NavigatorObserver>[
          observer
        ],
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(primaryColor: Colors.blue, accentColor: Colors.pink),
        supportedLocales: S.delegate.supportedLocales,
        title: 'Swaptime',
        routes: fullRoutesList,
        initialRoute: FormsRoutes.ROUTE_ADD_BY_IMAGE);
  }
}
