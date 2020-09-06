import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/camera/camera_module.dart';
import 'package:swaptime_flutter/module_chat/chat_module.dart';
import 'package:swaptime_flutter/module_forms/forms_module.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';

import 'di/components/app.component.dart';
import 'generated/l10n.dart';
import 'module_home/home.module.dart';

typedef Provider<T> = T Function();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
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
  final ChatModule _chatModule;
  final CameraModule _cameraModule;

  MyApp(
    this._homeModule,
    this._formsModule,
    this._chatModule,
    this._cameraModule,
  );

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutesList = {};

    fullRoutesList.addAll(_homeModule.getRoutes());
    fullRoutesList.addAll(_formsModule.getRoutes());
    fullRoutesList.addAll(_chatModule.getRoutes());
    fullRoutesList.addAll(_cameraModule.getRoutes());

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
        theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.pink),
        supportedLocales: S.delegate.supportedLocales,
        title: 'Swaptime',
        routes: fullRoutesList,
        initialRoute: HomeRoutes.ROUTE_HOME);
  }
}
