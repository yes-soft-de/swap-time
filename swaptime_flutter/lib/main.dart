import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'module_search/search_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  await firebaseMessaging.setAutoInitEnabled(true);
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
  final SearchModule _searchModule;

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
    this._searchModule,
  );

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  StreamSubscription iosSubscription;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.getToken().then((token) {
      if (token != null) {
        if (FirebaseAuth.instance.currentUser.uid != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection('notificationTokens')
              .add({token: true});
        }
      }
    });

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
    widget._localizationService.localizationStream.listen((event) {
      setState(() {});
    });

    widget._swapThemeService.darkModeStream.listen((event) {
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
    fullRoutesList.addAll(widget._searchModule.getRoutes());

    return getConfiguredApp(fullRoutesList);
  }

  Widget getConfiguredApp(Map<String, WidgetBuilder> fullRoutesList) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    return FutureBuilder(
      initialData: 'en',
      future: widget._localizationService.getLanguage(),
      builder: (BuildContext context, AsyncSnapshot<String> lang) {
        return FutureBuilder(
          future: widget._swapThemeService.isDarkMode(),
          initialData: false,
          builder:
              (BuildContext context, AsyncSnapshot<bool> isDarkModeEnabled) {
            return MaterialApp(
              navigatorObservers: <NavigatorObserver>[observer],
              locale: Locale.fromSubtags(
                languageCode: lang.data ?? 'en',
              ),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: isDarkModeEnabled.data == true
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
          },
        );
      },
    );
  }
}
