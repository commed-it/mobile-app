import 'package:flutter/material.dart';

import 'package:flutter_app/root/store/actions.dart';


@immutable
class PageControlState {
  final int currentPage;
  final PageController pageController = PageController(initialPage: 0);

  PageControlState(this.currentPage);

  PageControlState.init() : currentPage = 0;
}

PageControlState reducer(PageControlState prev,  PageControlAction action) {
  switch (action.runtimeType) {
    case MovePageFromPageController:
      action as MovePageFromPageController;
      return PageControlState(action.numPage);
    default:
      return prev;
  }
}
