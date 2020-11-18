import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/auth_routes.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';
import 'package:swaptime_flutter/module_localization/service/localization_service/localization_service.dart';
import 'package:swaptime_flutter/module_profile/presistance/profile_shared_preferences.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';

@provide
class SettingsPage extends StatefulWidget {
  final AuthService _authService;
  final LocalizationService _localizationService;
  final SwapThemeDataService _themeDataService;

  SettingsPage(
    this._authService,
    this._localizationService,
    this._themeDataService,
  );

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).username),
                  FutureBuilder(
                    future: ProfileSharedPreferencesHelper().getUsername(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<String> snapshot,
                    ) {
                      return Text(snapshot.data ?? S.of(context).notLoggedIn);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).darkMode),
                  StreamBuilder(
                    stream: widget._themeDataService.darkModeStream,
                    initialData: false,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<bool> snapshot,
                    ) {
                      return Switch(
                          value:
                              Theme.of(context).brightness == Brightness.dark,
                          onChanged: (mode) {
                            widget._themeDataService
                                .switchDarkMode(mode)
                                .then((value) {});
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).location),
                  FutureBuilder(
                    future: ProfileSharedPreferencesHelper().getUserLocation(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data);
                      }
                      return Text('');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).language),
                  FutureBuilder(
                    future: widget._localizationService.getLanguage(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return DropdownButton(
                          value: snapshot.data,
                          items: [
                            DropdownMenuItem(
                              child: Text('العربية'),
                              value: 'ar',
                            ),
                            DropdownMenuItem(
                              child: Text('English'),
                              value: 'en',
                            ),
                          ],
                          onChanged: (String newLang) {
                            widget._localizationService.setLanguage(newLang);
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.black12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: widget._authService.isLoggedIn,
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data) {
                    return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).signOut),
                        IconButton(
                            icon: Icon(Icons.logout),
                            onPressed: () {
                              widget._authService.logout().then((value) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    HomeRoutes.ROUTE_HOME, (route) => false);
                              });
                            })
                      ],
                    );
                  } else {
                    return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).login),
                        IconButton(
                            icon: Icon(Icons.login),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AuthRoutes.ROUTE_AUTHORIZE);
                            })
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
