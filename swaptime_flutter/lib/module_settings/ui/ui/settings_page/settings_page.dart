import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/service/auth_service/auth_service.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';
import 'package:swaptime_flutter/module_persistence/sharedpref/shared_preferences_helper.dart';
import 'package:swaptime_flutter/module_profile/presistance/profile_shared_preferences.dart';

@provide
class SettingsPage extends StatefulWidget {
  final AuthService _authService;

  SettingsPage(this._authService);

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
                  Text('Username: '),
                  FutureBuilder(
                    future: ProfileSharedPreferencesHelper().getUsername(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<String> snapshot,
                    ) {
                      return Text(' ' + snapshot.data.toString());
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
                  Text('Location'),
                  FutureBuilder(
                    future: ProfileSharedPreferencesHelper().getUserLocation(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data);
                      }
                      return Text(' ');
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
                  Text('Language'),
                  DropdownButton(
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
                        SharedPreferencesHelper().setLanguage(newLang);
                      })
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
                  Text('Sign out'),
                  IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        widget._authService.logout().then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeRoutes.ROUTE_HOME, (route) => false);
                        });
                      })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
