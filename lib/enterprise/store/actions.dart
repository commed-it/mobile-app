import 'package:flutter/material.dart';
import 'package:flutter_app/store/actions.dart';

@immutable
class NavigateToEnterpriseDetail extends AppAction {
  int enterpriseID;
  NavigateToEnterpriseDetail(this.enterpriseID);
}
