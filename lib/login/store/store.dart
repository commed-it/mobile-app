import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

@immutable
class LoginState {
  final bool isOnRegister;
  final String username;
  final String password;
  final String company;
  final String nif;
  final String repeatPassword;
  final String email;
  final String contact;

  const LoginState(this.isOnRegister, this.username, this.password,
      this.company, this.nif, this.repeatPassword, this.email, this.contact);

  LoginState.init()
      : isOnRegister = false,
        username = '',
        password = '',
        company = "",
        nif = "",
        repeatPassword = "",
        email = "",
        contact = "";
}

LoginState loginReducer(LoginState prev, AppAction action) {
  switch (action.runtimeType) {
    case TurnOnRegisterAction:
      return LoginState(true, prev.username, prev.password, prev.company,
          prev.nif, prev.repeatPassword, prev.email, prev.contact);
    case TurnOnLoginAction:
      return LoginState(false, prev.username, prev.password, prev.company,
          prev.nif, prev.repeatPassword, prev.email, prev.contact);
    case SetUsernameAction:
      SetUsernameAction actionN = action as SetUsernameAction;
      return LoginState(prev.isOnRegister, actionN.username, prev.password, prev.company,
          prev.nif, prev.repeatPassword, prev.email, prev.contact);
    case SetPasswordAction:
      var actionN = action as SetPasswordAction;
      return LoginState(prev.isOnRegister, prev.username, actionN.password, prev.company,
      prev.nif, prev.repeatPassword, prev.email, prev.contact);
    case SetCompanyAction:
      var actionN = action as SetCompanyAction;
      return LoginState(prev.isOnRegister, prev.username, prev.password, actionN.company,
          prev.nif, prev.repeatPassword, prev.email, prev.contact);
    case SetNifAction:
      var actionN = action as SetNifAction;
      return LoginState(prev.isOnRegister, prev.username, prev.password, prev.company,
          actionN.nif, prev.repeatPassword, prev.email, prev.contact);
    case SetRepeatPasswordAction:
      var actionN = action as SetRepeatPasswordAction;
      return LoginState(prev.isOnRegister, prev.username, prev.password, prev.company,
          prev.nif, actionN.repeatPassword, prev.email, prev.contact);
    case SetEmailAction:
      var actionN = action as SetEmailAction;
      return LoginState(prev.isOnRegister, prev.username, prev.password, prev.company,
          prev.nif, prev.repeatPassword, actionN.email, prev.contact);
    case SetContactAction:
      var actionN = action as SetContactAction;
      return LoginState(prev.isOnRegister, prev.username, prev.password, prev.company,
          prev.nif, prev.repeatPassword, prev.email, actionN.contact);
    default:
      return prev;
  }
}

AppState globalLoginReducer(AppState prev, AppAction action) {
  return AppState(prev.router, loginReducer(prev.loginViewState, action),
      prev.pageControlState);
}
