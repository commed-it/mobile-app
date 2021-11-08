import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/root/store/store.dart';

import 'actions.dart';

@immutable
class AppState {
  final LoginState loginViewState;
  final PageControlState pageControlState;
  final GlobalKey<NavigatorState> navigatorKey;

  // add User, ...
  AppState(this.loginViewState, this.pageControlState, this.navigatorKey);

  AppState.init()
      : loginViewState = LoginState.init(),
        pageControlState = PageControlState.init(),
        navigatorKey = GlobalKey<NavigatorState>();
}

AppState navigationReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case NavigateToNext:
      var newAction = action as NavigateToNext;
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushNamed(newAction.destinationRoute);
      return AppState(prev.loginViewState, prev.pageControlState, navKey);
    case NavigateToNextAndReplace:
      var newAction = action as NavigateToNextAndReplace;
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushReplacementNamed(newAction.destinationRoute);
      return AppState(prev.loginViewState, prev.pageControlState, navKey);
    case NavigateBack:
      GlobalKey<NavigatorState> navKey = prev.navigatorKey..currentState!.pop();
      return AppState(prev.loginViewState, prev.pageControlState, navKey);
  }
  return prev;
}

AppState appReducer(AppState prev, AppAction action) {
  print(action);
  prev = globalLoginReducer(prev, action);
  prev = globalPageControlReducer(prev, action);
  return prev;
}
