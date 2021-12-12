import 'package:flutter/material.dart';
import 'package:flutter_app/auth/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

AppState authenticationReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case ToggleAuthToken:
      var newAction = action as ToggleAuthToken;
      // something to log the user and get the state of the logged interface
      LoggedState loggedState = LoggedState.CouldntLog;
      switch (loggedState) {
        case LoggedState.Logged:
          GlobalKey<NavigatorState> navKey = prev.navigatorKey
            ..currentState!.pop()
            ..currentState!.pushReplacementNamed(Routes.home);
          return prev.copy(loggedState: loggedState, navigatorKey: navKey);
        case LoggedState.NotLogged:
          GlobalKey<NavigatorState> navKey = prev.navigatorKey
            ..currentState!.pop()
            ..currentState!.pushReplacementNamed(Routes.login);
          return prev.copy(loggedState: loggedState, navigatorKey: navKey);
        case LoggedState.CouldntLog:
          return prev.copy(loggedState: loggedState);
      }
  }
  return prev;
}
