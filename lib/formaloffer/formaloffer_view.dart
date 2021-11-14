import 'package:flutter/material.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';

class FormalOffersView extends StatelessWidget {
  const FormalOffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter : (sto) => sto.state.theme,
      builder: (cto, theme) => Container(
        color: theme.background.color,
        child: const Center(child: Text("Formal Offers")))
    );
  }
}
