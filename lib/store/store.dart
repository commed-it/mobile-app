import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/store.dart';
import 'package:flutter_app/generic/carrousel/exported.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/product/store/store.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/searcher/action.dart';
import 'package:flutter_app/store/theme.dart';

import 'actions.dart';

List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
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
  final List<Product> products;
  final CommedTheme theme;
  final Enterprise enterpriseDetail;
  final List<String> historicOfMessages;

  // add User, ...
  AppState(
      this.loginViewState,
      this.pageControlState,
      this.navigatorKey,
      this.products,
      this.theme,
      this.enterpriseDetail,
      this.historicOfMessages);

  // add User, ...

  AppState.init()
      : loginViewState = const LoginState.init(),
        pageControlState = PageControlState.init(),
        navigatorKey = GlobalKey<NavigatorState>(),
        products = List.filled(
                5,
                ProductContent(
                    ImageContainer(imgList),
                    "Name",
                    "DescriptionDescriptionDescriptionDe scrip32tionDescriptionDescriptionionDe323232scri ption Descr iptio nDescriptionDescriptionDescription",
                    false,
                    CompanySmallDetail(
                        "https://images.dog.ceo/breeds/boxer/n02108089_15702.jpg",
                        "Company Name")))
            .asMap()
            .map((index, value) => MapEntry(index, Product(index, value)))
            .values
            .toList(),
        theme = CommedTheme.init(),
        enterpriseDetail = const Enterprise.init(),
        historicOfMessages = List.generate(
            15, (index) => "This is a recommendation " + index.toString());

  AppState copy(
          {LoginState? loginViewState,
          PageControlState? pageControlState,
          GlobalKey<NavigatorState>? navigatorKey,
          List<Product>? products,
          CommedTheme? theme,
          Enterprise? enterpriseDetail,
          List<String>? historicOfMessages}) =>
      AppState(
          loginViewState ?? this.loginViewState,
          pageControlState ?? this.pageControlState,
          navigatorKey ?? this.navigatorKey,
          products ?? this.products,
          theme ?? this.theme,
          enterpriseDetail ?? this.enterpriseDetail,
          historicOfMessages ?? this.historicOfMessages);
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
    case DeleteRecommendationIndex:
      var actionD = action as DeleteRecommendationIndex;
      if (actionD.index < prev.historicOfMessages.length) {
        var removeAt = prev.historicOfMessages.toList()
          ..removeAt(actionD.index);
        return prev.copy(historicOfMessages: removeAt);
      }
      return prev;
  }
  return prev;
}

AppState appReducer(AppState prev, AppAction action) {
  prev = navigationReducer(prev, action);
  prev = globalLoginReducer(prev, action);
  prev = globalPageControlReducer(prev, action);
  prev = listProductsReducer(prev, action);
  prev = enterpriseReducer(prev, action);
  return prev;
}
