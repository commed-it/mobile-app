import 'package:flutter/material.dart';
import 'package:flutter_app/store/actions.dart';

class ToggleAuthToken extends AppAction {
  final bool authenticate;

  const ToggleAuthToken(this.authenticate);
}

@immutable
class LogoutAction extends AppAction {
  const LogoutAction();
}