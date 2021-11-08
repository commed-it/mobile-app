import 'package:flutter/material.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/store/router.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../pagecontrol_view.dart';

class PageControlRouter extends RouterA {
  @override
  Widget getWidget() {
    return  const PageControlWidget();
  }
}
