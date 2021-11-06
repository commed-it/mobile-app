
import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/store/router.dart';
import 'package:intl/date_symbols.dart';

@immutable
class AppState {
  final RouterA router;
  final LoginState loginViewState;
  // add User, ...
  AppState(this.router, this.loginViewState);

  AppState.init() : router = TODO, loginViewState = LoginState.init();
}


typedef RouterA RouterAction(RouterA);

final List<RouterA> reducerRouterList = List<RouterA>.empty();