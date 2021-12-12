import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/auth/store.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/store.dart';
import 'package:flutter_app/formaloffer/model/formaloffer.dart';
import 'package:flutter_app/formaloffer/store/store.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/product/store/store.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/searcher/action.dart';
import 'package:flutter_app/searcher/model.dart';
import 'package:flutter_app/service/middleware_service.dart';
import 'package:flutter_app/service/store.dart';
import 'package:flutter_app/store/theme.dart';

import 'actions.dart';

typedef AppStateFunction = AppState Function(AppState state);

@immutable
class LambdaAction extends AppAction {
  final AppStateFunction func;

  const LambdaAction(this.func);
}

@immutable
class AppState {
  final LoginState loginViewState;
  final PageControlState pageControlState;
  final GlobalKey<NavigatorState> navigatorKey;
  final HashMap<int, Product> products;
  final List<FormalOffer> formalOffers;
  final CommedTheme theme;
  final Enterprise enterpriseDetail;
  final Searcher searcher;
  final bool isLogged;
  final CommedMiddleware commedMiddleware;
  final Enterprise myEnterpriseDetail;

  // add User, ...
  AppState(
      this.loginViewState,
      this.pageControlState,
      this.navigatorKey,
      this.products,
      this.formalOffers,
      this.theme,
      this.enterpriseDetail,
      this.myEnterpriseDetail,
      this.searcher,
      this.isLogged,
      this.commedMiddleware);

  // add User, ...

  AppState.init()
      : loginViewState = const LoginState.init(),
        pageControlState = PageControlState.init(),
        navigatorKey = GlobalKey<NavigatorState>(),
        products = HashMap(),
        formalOffers = List.empty(),
        theme = CommedTheme.init(),
        enterpriseDetail = const Enterprise.init(),
        myEnterpriseDetail = const Enterprise.init(),
        searcher = Searcher.init(),
        isLogged = false,
        commedMiddleware = CommedMiddleware();

  AppState copy(
          {LoginState? loginViewState,
          PageControlState? pageControlState,
          GlobalKey<NavigatorState>? navigatorKey,
          HashMap<int, Product>? products,
          List<FormalOffer>? formalOffers,
          CommedTheme? theme,
          Enterprise? enterpriseDetail,
          Enterprise? myEnterpriseDetail,
          Searcher? searcher,
          bool? isLogged}) =>
      AppState(
          loginViewState ?? this.loginViewState,
          pageControlState ?? this.pageControlState,
          navigatorKey ?? this.navigatorKey,
          products ?? this.products,
          formalOffers ?? this.formalOffers,
          theme ?? this.theme,
          enterpriseDetail ?? this.enterpriseDetail,
          myEnterpriseDetail ?? this.myEnterpriseDetail,
          searcher ?? this.searcher,
          isLogged ?? this.isLogged,
          this.commedMiddleware);
}

AppState navigationReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case NavigateToNext:
      var newAction = action as NavigateToNext;
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushNamed(newAction.destinationRoute);
      return prev.copy(navigatorKey: navKey);
    case NavigateToNextAndReplace:
      var newAction = action as NavigateToNextAndReplace;
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushReplacementNamed(newAction.destinationRoute);
      return prev.copy(navigatorKey: navKey);
    case NavigateBack:
      GlobalKey<NavigatorState> navKey = prev.navigatorKey..currentState!.pop();
      return prev.copy(navigatorKey: navKey);
    case LambdaAction:
      return (action as LambdaAction).func(prev);
  }
  return prev;
}

AppState appReducer(AppState prev, action) {
  if (action is AppAction) {
    prev = navigationReducer(prev, action);
    prev = authenticationReducer(prev, action);
    prev = globalLoginReducer(prev, action);
    prev = globalPageControlReducer(prev, action);
    prev = listProductsReducer(prev, action);
    prev = enterpriseReducer(prev, action);
    prev = searcherReducer(prev, action);
    prev = listProductsReducerService(prev, action);
    prev = formalOfferReducer(prev, action);
  }
  return prev;
}
