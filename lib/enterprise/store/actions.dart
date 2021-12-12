import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/store/actions.dart';

@immutable
class NavigateToEnterpriseDetail extends AppAction {
  Enterprise enterprise;
  NavigateToEnterpriseDetail(this.enterprise);
}

@immutable
class setMyEnterpriseDetail extends AppAction {
  Enterprise enterprise;
  setMyEnterpriseDetail(this.enterprise);
}