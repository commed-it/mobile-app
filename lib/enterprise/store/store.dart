import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/service/middleware_service.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

import 'actions.dart';

AppState enterpriseReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case NavigateToEnterpriseDetail:
      var new_action = action as NavigateToEnterpriseDetail;
      GlobalKey<NavigatorState> navKey = prev.navigatorKey
        ..currentState!.pushNamed(Routes.enterprise);
      return prev.copy(enterpriseDetail: new_action.enterprise, navigatorKey: navKey);
    default:
      return prev;
  }
}
