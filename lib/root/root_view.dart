import 'package:flutter/material.dart';
import 'package:flutter_app/store/router.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class RootWidget extends StatelessWidget {
  final store = Store<AppState>((x, a) => appReducer(x, a),
      initialState: AppState.init());

  RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(store: store, child: _RouterWidget());
  }
}

class _RouterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RouterA>(
        builder: (context, router) {
          return router.getWidget();
        },
        converter: (store) => store.state.router);
  }
}