import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/product/home_view.dart';
import 'package:flutter_app/root/pagecontrol_view.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
        converter: (sto) => sto.state.isLogged,
        builder: (cto, isLogged) =>
            isLogged ? PageControlWidget() : NotLoggedView());
  }
}

class NotLoggedView extends StatelessWidget {
  const NotLoggedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (sto) => sto.state.theme,
      builder: (cto, theme) => Scaffold(
        body: HomeView(),
        appBar: buildNotloggedAppBar(context, theme),
        floatingActionButton: SpeedDial(
          backgroundColor: theme.primary.color,
          icon: Icons.login,
          activeIcon: Icons.close,
          spacing: 3,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.accessibility),
              backgroundColor: theme.primary.color,
              foregroundColor: Colors.white,
              label: 'Login',
              onTap: () => debugPrint("FIRST CHILD"),
            ),
            SpeedDialChild(
              child: const Icon(Icons.accessibility),
              backgroundColor: theme.accent.color,
              foregroundColor: Colors.white,
              label: 'Register',
              onTap: () => debugPrint("FIRST CHILD"),
            )
          ],
        ),
      ),
    );
  }
}

AppBar buildNotloggedAppBar(BuildContext context, CommedTheme theme) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: theme.appBarColor),
    backgroundColor: theme.appBarColor,
    title: Image.asset(
      'assets/logo-white.png',
      fit: BoxFit.cover,
      height: 50,
    ),
    actions: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: StoreConnector<AppState, VoidCallback>(
            converter: (store) =>
                () => store.dispatch(const NavigateToNext(Routes.searcher)),
            builder: (ctx, callback) => IconButton(
              icon: Icon(Icons.search, color: theme.primary.textColor),
              onPressed: callback,
            ),
          )),
    ],
    elevation: 0,
  );
}
