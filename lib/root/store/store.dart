import 'package:flutter/material.dart';
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
      return AppState(prev.loginViewState,
          PageControlState(action.numPage), prev.navigatorKey);
    case ProfileButtonAction:
      return AppState(prev.loginViewState,
          prev.pageControlState, prev.navigatorKey);
    default:
      return prev;
  }
}
