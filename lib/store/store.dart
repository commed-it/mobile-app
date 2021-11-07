
import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/root/store/route.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/store/router.dart';
import 'package:intl/date_symbols.dart';

@immutable
class AppState {
  final RouterA router;
  final LoginState loginViewState;
  final PageControlState pageControlState;
  // add User, ...
  AppState(this.router, this.loginViewState, this.pageControlState);

  AppState.init() : router = PageControlRouter(), loginViewState = LoginState.init(), pageControlState = PageControlState.init();
}


typedef RouterA RouterAction(RouterA);

final List<RouterA> reducerRouterList = List<RouterA>.empty();