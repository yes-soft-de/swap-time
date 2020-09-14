import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_auth/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:swaptime_flutter/module_auth/states/auth_states/auth_states.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';
import 'package:swaptime_flutter/module_navigation/ui/widget/navigation_drawer/swap_navigation_drawer.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';
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
  String countryCode = '+963';

  final GlobalKey _confirmCodeKey = GlobalKey<FormState>();
  final TextEditingController _confirmationController = TextEditingController();

  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String redirectTo = ModalRoute.of(context).settings.arguments.toString();
    redirectTo = redirectTo ?? HomeRoutes.ROUTE_HOME;

    widget.manager.stateStream.listen((event) {
      _currentState = event;
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
          drawer: SwapNavigationDrawer(),
          appBar: SwaptimeAppBar.getSwaptimeAppBar(_scaffoldKey),
          body: _getCodeSetter());
      if (mounted) setState(() {});
    } else if (_currentState is AuthStateLoading) {
      loading = true;
      if (mounted) setState(() {});
    } else {
      pageLayout = Scaffold(
        drawer: SwapNavigationDrawer(),
        appBar: SwaptimeAppBar.getSwaptimeAppBar(_scaffoldKey),
        body: _getPhoneSetter(),
      );
      if (mounted) setState(() {});
    }
  }

  Widget _getCodeSetter() {
    return Form(
      key: _confirmCodeKey,
      child: SingleChildScrollView(
        child: Container(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_phoneController.text.trim()),
              TextFormField(
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
              _errorMsg != null ? Text(_errorMsg) : Container(),
              RaisedButton(
                child: Text('Confirm!'),
                onPressed: () {
                  widget.manager.confirmWithCode(_phoneController.text);
                },
              )
            ],
          ),
        ),
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
          Container(),
          SvgPicture.asset('assets/images/logo.svg'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DropdownButton(
                  onChanged: (v) {
                    countryCode = v;
                  },
                  value: '+963',
                  items: [
                    DropdownMenuItem(
                      value: '+966',
                      child: Text('Saudi Arabia'),
                    ),
                    DropdownMenuItem(
                      value: '+961',
                      child: Text('Lebanon'),
                    ),
                    DropdownMenuItem(
                      value: '+963',
                      child: Text('Syria'),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Phone Number', hintText: '123 456 789'),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Please Input Phone Number';
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
          _errorMsg != null ? Text(_errorMsg) : Container(),
          GestureDetector(
            onTap: () {
              String phone = _phoneController.text;
              if (phone[0] == '0') {
                phone = phone.substring(1);
              }
              widget.manager
                  .SignInWithPhone(countryCode + _phoneController.text);
            },
            child: Container(
              decoration: BoxDecoration(color: SwapThemeData.getAccent()),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loading == true ? 'Loading!' : 'Send me a Code!',
                      style: TextStyle(
                        fontSize: 24,
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
