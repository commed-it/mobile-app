import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/product/home_view.dart';
import 'package:flutter_app/root/pagecontrol_view.dart';
import 'package:flutter_app/root/store/actions.dart';
import 'package:flutter_app/service/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/appbar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (sto) => () => sto.dispatch(reloadProducts()),
      builder: (cto, callback) => StoreConnector<AppState, bool>(
          converter: (sto) => sto.state.isLogged,
          builder: (cto, isLogged) =>
              isLogged ? PageControlWidget() : NotLoggedView(),
        onInit: (sto) => callback(),
      ),
    );
  }
}

class NotLoggedView extends StatelessWidget {
  const NotLoggedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (sto) => sto.state.theme,
      builder: (cto, theme) => Scaffold(
        body: HomeView(isAuthenticated : false),
        appBar: buildNotloggedAppBar(context, theme),
        floatingActionButton: StoreConnector<AppState, Function(dynamic)>(
          converter : (sto) => (isOnLoggin) => () => isOnLoggin ? sto.dispatch(const NavigateToNext(Routes.login)) : sto.dispatch(const NavigatoToRegisterAction()),
          builder: (cto, loginCallback) => SpeedDial(
            backgroundColor: theme.primary.color,
            icon: Icons.login,
            label: Text("Login"),
            activeIcon: Icons.close,
            activeBackgroundColor: theme.unselectedLabel,
            activeLabel: Text("Close"),
            spacing: 3,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.login),
                backgroundColor: theme.primary.color,
                foregroundColor: Colors.white,
                label: 'Login',
                onTap: loginCallback(true),
              ),
              SpeedDialChild(
                child: const Icon(Icons.group_add),
                backgroundColor: theme.primary.color,
                foregroundColor: Colors.white,
                label: 'Register',
                onTap: loginCallback(false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
