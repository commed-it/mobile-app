
import 'package:flutter/material.dart';
import 'package:flutter_app/root/store/store.dart';
import 'package:flutter_app/store/router.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants.dart';
import '../pagecontrol_view.dart';

import 'package:redux/redux.dart';

class PageControlRouter extends RouterA {
  final store = Store<PageControlState>((x, a) => x, initialState: PageControlState.init());

  @override
  Widget getWidget() {
    return StoreProvider<PageControlState>(store: store, child: PageControlWidget());
  }

}
