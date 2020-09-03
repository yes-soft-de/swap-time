import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/auth_module/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:swaptime_flutter/auth_module/states/auth_states/auth_states.dart';
import 'package:swaptime_flutter/module_home/home.routes.dart';

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

  final GlobalKey _confirmCodeKey = GlobalKey<FormState>();
  final TextEditingController _confirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String redirectTo = ModalRoute.of(context).settings.arguments.toString();
    redirectTo = redirectTo ?? HomeRoutes.ROUTE_HOME;

    widget.manager.stateStream.listen((event) {
      _currentState = event;
      _getUI();
      if (!(_currentState is AuthStateSuccess)) {
        if (mounted) setState(() {});
      }
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
      pageLayout = Scaffold(body: _getCodeSetter());
    } else {
      pageLayout = Scaffold(
        body: _getPhoneSetter(),
      );
    }
  }

  Widget _getCodeSetter() {
    return Form(
      key: _confirmCodeKey,
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
    );
  }

  Widget _getPhoneSetter() {
    return Form(
      key: _signUpFormKey,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Phone Number', hintText: '+966 123 456 789'),
            validator: (v) {
              if (v.isEmpty) {
                return 'Please Input Phone Number';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
          ),
          _errorMsg != null ? Text(_errorMsg) : Container(),
          RaisedButton(
            child: Text('Send me the Code'),
            onPressed: () {
              widget.manager.SignInWithPhone(_phoneController.text);
            },
          )
        ],
      ),
    );
  }
}
