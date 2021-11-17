import 'package:flutter/material.dart';
import 'package:flutter_app/auth/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

AppState authenticationReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case ToggleAuthToken:
      var newAction = action as ToggleAuthToken;
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushReplacementNamed(Routes.home);
      return prev.copy(isLogged: newAction.authenticate, navigatorKey: navKey);
  }
  return prev;
}
