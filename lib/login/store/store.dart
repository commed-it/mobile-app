import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

@immutable
class LoginState {
  final bool isOnRegister;
  final String username;
  final String password;

  const LoginState(this.isOnRegister, this.username, this.password);

  LoginState.init()
      : isOnRegister = false,
        username = '',
        password = '';
}

LoginState loginReducer(LoginState prev, AppAction action) {
  switch (action.runtimeType) {
    case TurnOnRegisterAction:
      return LoginState(true, prev.username, prev.password);
    case TurnOnLoginAction:
      return LoginState(false, prev.username, prev.password);
    default:
      return prev;
  }
}

AppState globalLoginReducer(AppState prev, AppAction action) {
  return AppState(prev.router, loginReducer(prev.loginViewState, action),
      prev.pageControlState);
}
