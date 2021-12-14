import 'package:flutter/material.dart';
import 'package:flutter_app/auth/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

AppState authenticationReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case LoginAction:
      GlobalKey<NavigatorState> navKey = prev.navigatorKey..currentState!.pop()
        ..currentState!.pushReplacementNamed(Routes.home);
      return prev.copy(loggedState: LoggedState.Logged, navigatorKey: navKey);
    case LogoutAction:
      GlobalKey<NavigatorState> navKey = prev.navigatorKey;
      while (navKey.currentState!.canPop()) {
        navKey = navKey..currentState!.pop();
      }
      navKey = navKey..currentState!.pushNamed(Routes.home);
      return prev.copy(loggedState: LoggedState.NotLogged, navigatorKey: navKey);
    case CouldntLogAction:
      return prev.copy(loggedState: LoggedState.CouldntLog);
    case SetUserId:
      action = action as SetUserId;
      return prev.copy(userId: action.ID);
  }
  return prev;
}
