import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/auth/store.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/store.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/product/store/store.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/searcher/action.dart';
import 'package:flutter_app/searcher/model.dart';
import 'package:flutter_app/service/commed_api.dart';
import 'package:flutter_app/service/middleware_service.dart';
import 'package:flutter_app/service/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/carroussel.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'actions.dart';

List<String> bicicletaImageList = [
  "https://instagram.fbcn7-2.fna.fbcdn.net/v/t51.2885-15/e35/255858093_469135257869381_6653683263538409749_n.jpg?_nc_ht=instagram.fbcn7-2.fna.fbcdn.net&_nc_cat=105&_nc_ohc=83KlgONymIoAX_-hMc-&edm=AABBvjUBAAAA&ccb=7-4&oh=ecec01dccc7118a2e65013db041ed9a0&oe=619BFB74&_nc_sid=83d603",
  "https://instagram.fbcn7-2.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/222854503_991402534928079_1208240465553245294_n.jpg?_nc_ht=instagram.fbcn7-2.fna.fbcdn.net&_nc_cat=103&_nc_ohc=iw8vN24ekIsAX8UQtGH&edm=AP_V10EBAAAA&ccb=7-4&oh=b47484986a47883da10a1a6886d228bb&oe=619C0C3F&_nc_sid=4f375e",
  "https://instagram.fbcn7-2.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/225119727_249351956766946_5572182716211699871_n.jpg?_nc_ht=instagram.fbcn7-2.fna.fbcdn.net&_nc_cat=110&_nc_ohc=oCtxhiayOC8AX_hzbUH&edm=AP_V10EBAAAA&ccb=7-4&oh=ffdf872d80464cf00aad15fd0df8ddb0&oe=619B1799&_nc_sid=4f375e",
];
List<String> rodiImageList = [
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmontserratcentre.com%2Fwp-content%2Fuploads%2F2015%2F11%2FRODI-MOTOR-3.jpg&f=1&nofb=1",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Foriolcastello.com%2Fwp-content%2Fuploads%2F2019%2F05%2FZ6A1293.jpg&f=1&nofb=1",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.lavanguardia.com%2Ffiles%2Fog_thumbnail%2Fuploads%2F2018%2F02%2F02%2F5f1602a78773c.jpeg&f=1&nofb=1",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.pinimg.com%2F736x%2F3f%2F49%2Fa0%2F3f49a04ac8a6d48daa164afe3393a736.jpg&f=1&nofb=1"
];

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
  final CommedTheme theme;
  final Enterprise enterpriseDetail;
  final Searcher searcher;
  final bool isLogged;
  final CommedMiddleware commedMiddleware;

  // add User, ...
  AppState(
      this.loginViewState,
      this.pageControlState,
      this.navigatorKey,
      this.products,
      this.theme,
      this.enterpriseDetail,
      this.searcher,
      this.isLogged,
      this.commedMiddleware);

  // add User, ...

  AppState.init()
      : loginViewState = const LoginState.init(),
        pageControlState = PageControlState.init(),
        navigatorKey = GlobalKey<NavigatorState>(),
        products = HashMap(),
        theme = CommedTheme.init(),
        enterpriseDetail = const Enterprise.init(),
        searcher = Searcher.init(),
        isLogged = false,
        commedMiddleware = CommedMiddleware();

  AppState copy(
          {LoginState? loginViewState,
          PageControlState? pageControlState,
          GlobalKey<NavigatorState>? navigatorKey,
          HashMap<int, Product>? products,
          CommedTheme? theme,
          Enterprise? enterpriseDetail,
          Searcher? searcher,
          bool? isLogged}) =>
      AppState(
          loginViewState ?? this.loginViewState,
          pageControlState ?? this.pageControlState,
          navigatorKey ?? this.navigatorKey,
          products ?? this.products,
          theme ?? this.theme,
          enterpriseDetail ?? this.enterpriseDetail,
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
  print(action);
  if (action is AppAction) {
    prev = navigationReducer(prev, action);
    prev = authenticationReducer(prev, action);
    prev = globalLoginReducer(prev, action);
    prev = globalPageControlReducer(prev, action);
    prev = listProductsReducer(prev, action);
    prev = enterpriseReducer(prev, action);
    prev = searcherReducer(prev, action);
    prev = listProductsReducerService(prev, action);
  }
  return prev;
}
