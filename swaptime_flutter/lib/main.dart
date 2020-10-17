import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/camera/camera_module.dart';
import 'package:swaptime_flutter/games_module/games_module.dart';
import 'package:swaptime_flutter/module_auth/auth_module.dart';
import 'package:swaptime_flutter/module_chat/chat_module.dart';
import 'package:swaptime_flutter/module_forms/forms_module.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';
import 'package:swaptime_flutter/module_profile/profile_module.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

import 'di/components/app.component.dart';
import 'generated/l10n.dart';
import 'module_home/home.module.dart';
import 'module_localization/service/localization_service/localization_service.dart';

typedef Provider<T> = T Function();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    final container = await AppComponent.create();
    runApp(container.app);
  });
}

@provide
class MyApp extends StatefulWidget {
  final HomeModule _homeModule;
  final FormsModule _formsModule;
  final ChatModule _chatModule;
  final CameraModule _cameraModule;
  final AuthModule _authModule;
  final ProfileModule _profileModule;
  final GamesModule _gamesModule;
  final LocalizationService _localizationService;
  final SwapThemeDataService _swapThemeService;

  MyApp(
    this._homeModule,
    this._formsModule,
    this._gamesModule,
    this._authModule,
    this._chatModule,
    this._cameraModule,
    this._profileModule,
    this._localizationService,
    this._swapThemeService,
  );

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  String lang;
  bool isDarkMode;

  @override
  void initState() {
    super.initState();

    widget._localizationService.localizationStream.listen((event) {
      lang = event;
      setState(() {});
    });

    widget._swapThemeService.darkModeStream.listen((event) {
      isDarkMode = event;
      print('Dark Mode: ' + isDarkMode.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> fullRoutesList = {};

    fullRoutesList.addAll(widget._homeModule.getRoutes());
    fullRoutesList.addAll(widget._formsModule.getRoutes());
    fullRoutesList.addAll(widget._chatModule.getRoutes());
    fullRoutesList.addAll(widget._authModule.getRoutes());
    fullRoutesList.addAll(widget._cameraModule.getRoutes());
    fullRoutesList.addAll(widget._profileModule.getRoutes());
    fullRoutesList.addAll(widget._gamesModule.getRoutes());

    return FutureBuilder(
      future: getConfiguredApp(fullRoutesList),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        return snapshot.data;
      },
    );
  }

  Future<Widget> getConfiguredApp(
    Map<String, WidgetBuilder> fullRoutesList,
  ) async {
    lang ??= await widget._localizationService.getLanguage();
    isDarkMode ??= await widget._swapThemeService.isDarkMode();

    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      locale: Locale.fromSubtags(
        languageCode: lang ?? 'en',
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: isDarkMode == true
          ? ThemeData(
              brightness: Brightness.dark,
            )
          : ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.white,
            ),
      supportedLocales: S.delegate.supportedLocales,
      title: 'Swaptime',
      routes: fullRoutesList,
      initialRoute: HomeRoutes.ROUTE_HOME,
    );
  }
}
