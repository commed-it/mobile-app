import 'package:flutter/material.dart';
import 'package:flutter_app/store/actions.dart';

@immutable
class TurnOnRegisterAction extends AppAction {
  const TurnOnRegisterAction();
}

@immutable
class TurnOnLoginAction extends AppAction {
  const TurnOnLoginAction();
}

@immutable
class SetUsernameAction extends AppAction {
  final String username;

  SetUsernameAction(this.username);
}

@immutable
class SetPasswordAction extends AppAction {
  final String password;

  SetPasswordAction(this.password);
}

@immutable
class SetCompanyAction extends AppAction {
  final String company;

  SetCompanyAction(this.company);
}

@immutable
class SetNifAction extends AppAction {
  final String nif;

  SetNifAction(this.nif);
}

@immutable
class SetRepeatPasswordAction extends AppAction {
  final String repeatPassword;

  SetRepeatPasswordAction(this.repeatPassword);
}

@immutable
class SetEmailAction extends AppAction {
  final String email;

  SetEmailAction(this.email);
}

@immutable
class SetContactAction extends AppAction {
  final String contact;

  SetContactAction(this.contact);
}
