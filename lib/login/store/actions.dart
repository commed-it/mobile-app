
import 'package:flutter/material.dart';

@immutable
abstract class LoginAction {
  const LoginAction();
}

@immutable
class TurnOnRegisterAction extends LoginAction {
  const TurnOnRegisterAction();
}

@immutable
class TurnOnLoginAction extends LoginAction {
  const TurnOnLoginAction();
}
