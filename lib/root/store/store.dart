import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

import './actions.dart';

@immutable
class PageControlState {
  final int currentPage;
  final PageController pageController = PageController(initialPage: 0);

  PageControlState(this.currentPage);

  PageControlState.init() : currentPage = 0;
}

AppState globalPageControlReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case MovePageFromPageController:
      action = action as MovePageFromPageController;
      return prev.copy(pageControlState: PageControlState(action.numPage));
    case NavigatoToRegisterAction:
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushNamed(Routes.login);
      LoginState loginState = prev.loginViewState.copy(isOnRegister: true);
      return prev.copy(navigatorKey: navKey, loginViewState: loginState);
    default:
      return prev;
  }
}
