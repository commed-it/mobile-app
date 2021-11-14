import 'package:flutter/material.dart';
import 'package:flutter_app/store/actions.dart';

@immutable
class ChangeEnterpriseDetail extends AppAction {
  int enterpriseID;
  ChangeEnterpriseDetail(this.enterpriseID);
}
