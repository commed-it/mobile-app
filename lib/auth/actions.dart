import 'package:flutter/material.dart';
import 'package:flutter_app/store/actions.dart';

class LoginAction extends AppAction {
  final bool authenticate;

  const LoginAction(this.authenticate);
}

@immutable
class LogoutAction extends AppAction {
  const LogoutAction();
}

@immutable
class CouldntLogAction extends AppAction {
  const CouldntLogAction();
}
