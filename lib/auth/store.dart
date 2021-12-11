import 'package:flutter/material.dart';
import 'package:flutter_app/auth/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

AppState authenticationReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case ToggleAuthToken:
      var newAction = action as ToggleAuthToken;
      GlobalKey<NavigatorState> navKey = prev.navigatorKey..currentState!.pop()
        ..currentState!.pushReplacementNamed(Routes.home);
      return prev.copy(isLogged: newAction.authenticate, navigatorKey: navKey);
    case LogoutAction:
      GlobalKey<NavigatorState> navKey = prev.navigatorKey;
      while (navKey.currentState!.canPop()) {
        navKey = navKey..currentState!.pop();
      }
      navKey = navKey..currentState!.pushNamed(Routes.home);
      return prev.copy(isLogged: false, navigatorKey: navKey);
  }
  return prev;
}
