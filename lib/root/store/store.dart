import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/route.dart';
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
      action as MovePageFromPageController;
      return AppState(prev.router, prev.loginViewState, PageControlState(action.numPage));
    case ProfileButtonAction:
      return AppState(LoginRouter(), prev.loginViewState, prev.pageControlState);
    default:
      return prev;
  }
}
