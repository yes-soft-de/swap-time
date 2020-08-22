import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_persistence/sharedpref/shared_preferences_helper.dart';
import 'package:swaptime_flutter/user_authorization_module/bloc/create_profile/create_profile_bloc.dart';

import '../../../user_auth_routes.dart';

@provide
class CreateProfileScreen extends StatefulWidget {
  final CreateProfileBloc _profileBloc;
  final SharedPreferencesHelper _preferencesHelper;

  CreateProfileScreen(this._profileBloc, this._preferencesHelper);

  @override
  State<StatefulWidget> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String _gender;
  String _guideLanguage;

  @override
  Widget build(BuildContext context) {
    widget._profileBloc.profileStatus.listen((event) {
      if (widget != null) {
        Navigator.pushNamed(context, UserAuthorizationRoutes.createIntentions);
      }
    });

    widget._preferencesHelper.getUserUID().then((value) {
      log('UserID: ' + value);
    });

    return Scaffold(
      body: ListView(
        children: <Widget>[
          // LOGO
          Container(
            height: 156,
            width: 156,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 156,
                  width: 156,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(78),
                      color: Colors.green),
                ),
                Image.asset(
                  'resources/images/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          // Divider
          Container(
            height: 56,
          ),
          Container(
            width: 156,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please Enter Some Text';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      items: <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                          value: null,
                          child: Text('Select a Language'),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text('Arabic'),
                        ),
                      ],
                      onChanged: (String value) {
                        this._guideLanguage = value;
                      },
                    ),
                    DropdownButtonFormField(
                      hint: Text('Select a Gender'),
                      items: <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                          value: 'male',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: 'female',
                          child: Text('Female'),
                        ),
                      ],
                      onChanged: (String value) {
                        this._gender = value;
                      },
                    ),
                    Container(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        _createProfile();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          height: 40,
                          width: 160,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.greenAccent)),
                          alignment: Alignment.center,
                          child: Text('Next'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _createProfile() {
    if (_guideLanguage == null) {
      log('Null Language');
      Fluttertoast.showToast(
          msg: 'Please Select a language',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
      return;
    }

    log('Language is ' + _guideLanguage);
    Fluttertoast.showToast(
        msg: 'Saving Data',
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);

    widget._profileBloc
        .createProfile(_nameController.text, _gender, _guideLanguage);
  }
}
