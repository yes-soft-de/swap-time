import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/generated/l10n.dart';
import 'package:swaptime_flutter/module_auth/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:swaptime_flutter/module_auth/states/auth_states/auth_states.dart';
import 'package:swaptime_flutter/module_profile/profile_routes.dart';
import 'package:swaptime_flutter/module_theme/service/theme_service/theme_service.dart';
import 'package:swaptime_flutter/utils/app_bar/swaptime_app_bar.dart';

@provide
class AuthScreen extends StatefulWidget {
  final AuthStateManager manager;

  AuthScreen(this.manager);

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _errorMsg;
  AuthState _currentState;
  Scaffold pageLayout;

  final GlobalKey _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  String countryCode;

  final GlobalKey _confirmCodeKey = GlobalKey<FormState>();
  final TextEditingController _confirmationController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    String redirectTo = ModalRoute.of(context).settings.arguments.toString();
    redirectTo =
        redirectTo == null ? redirectTo : ProfileRoutes.MY_ROUTE_PROFILE;

    Future.delayed(Duration(seconds: 1)).then((value) {
      widget.manager.isSignedIn().then((value) {
        if (value) Navigator.of(context).pushReplacementNamed(redirectTo);
      });
    });

    widget.manager.stateStream.listen((event) {
      _currentState = event;
      loading = false;
      _getUI();
    });

    if (_currentState is AuthStateSuccess) {
      Navigator.of(context).pushReplacementNamed(redirectTo);
    }
    if (_currentState is AuthStateError) {
      AuthStateError errorState = _currentState;
      _errorMsg = errorState.errorMsg;
    }

    _getUI();
    return pageLayout;
  }

  void _getUI() {
    if (_currentState is AuthStateCodeSent) {
      pageLayout = Scaffold(
          appBar: SwaptimeAppBar.getBackEnabledAppBar(),
          body: _getCodeSetter());
      if (mounted) setState(() {});
    } else if (_currentState is AuthStateLoading) {
      loading = true;
      if (mounted) setState(() {});
    } else {
      pageLayout = Scaffold(
        appBar: SwaptimeAppBar.getBackEnabledAppBar(),
        body: _getPhoneSetter(),
      );
      if (mounted) setState(() {});
    }
  }

  Widget _getCodeSetter() {
    return Form(
      key: _confirmCodeKey,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? SvgPicture.asset('assets/images/logo.svg')
                  : Container(),
              Text(_phoneController.text.trim()),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: _confirmationController,
                decoration: InputDecoration(
                  labelText: 'Confirmation Code',
                  hintText: '12345',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Please Input Phone Number';
                  }
                  return null;
                }),
          ),
          _errorMsg != null ? Text(_errorMsg) : Container(),
          Container(
            decoration: BoxDecoration(color: SwapThemeDataService.getAccent()),
            child: GestureDetector(
              onTap: () {
                loading = true;
                if (mounted) setState(() {});
                widget.manager.confirmWithCode(_phoneController.text);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      loading == false ? 'Confirm!' : 'Loading!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPhoneSetter() {
    return Form(
      key: _signUpFormKey,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? SvgPicture.asset('assets/images/logo.svg')
                  : Container(),
              Flex(direction: Axis.vertical, children: []),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButton(
                      onChanged: (v) {
                        countryCode = v;
                        if (mounted) setState(() {});
                      },
                      value: countryCode,
                      items: [
                        DropdownMenuItem(
                          value: '+966',
                          child: Text(S.of(context).saudiArabia),
                        ),
                        DropdownMenuItem(
                          value: '+1',
                          child: Text(S.of(context).usa),
                        ),
                        DropdownMenuItem(
                          value: '+961',
                          child: Text(S.of(context).lebanon),
                        ),
                        DropdownMenuItem(
                          value: '+963',
                          child: Text(S.of(context).syria),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                              labelText: S.of(context).phoneNumber,
                              hintText: '123 456 789'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return S.of(context).pleaseInputPhoneNumber;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _errorMsg != null ? Text(_errorMsg) : Container(),
          GestureDetector(
            onTap: () {
              String phone = _phoneController.text;
              if (phone[0] == '0') {
                phone = phone.substring(1);
              }
              loading = true;
              if (mounted) setState(() {});
              widget.manager
                  .SignInWithPhone(countryCode + _phoneController.text);
            },
            child: Container(
              decoration:
                  BoxDecoration(color: SwapThemeDataService.getAccent()),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loading == true
                          ? S.of(context).loading
                          : S.of(context).sendMeACode,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
