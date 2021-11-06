import 'package:flutter/material.dart';

import 'actions.dart';

@immutable
class LoginState {
  final bool isOnRegister;
  final String username;
  final String password;

  const LoginState(this.isOnRegister, this.username, this.password);
}

LoginState reducer(LoginState prev, action) {
  switch (action) {
    case TurnOnRegisterAction:
      return LoginState(true, prev.username, prev.password);
    case TurnOnLoginAction:
      return LoginState(false, prev.username, prev.password);
    default:
      return prev;
  }
}
