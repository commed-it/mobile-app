
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/auth/actions.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';

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


AppBar buildAppBarLogged(BuildContext context, CommedTheme theme) {
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
      ProfileAppBarButton(theme: theme),
    ],
    elevation: 0,
  );
}

enum PopMenuOptions { SETTINGS, LOGOUT }

class ProfileAppBarButton extends StatelessWidget {
  CommedTheme theme;

  ProfileAppBarButton({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: StoreConnector<AppState, Function(dynamic)>(
          builder: (context, callback) {
            return PopupMenuButton(
                itemBuilder: (cto) => <PopupMenuEntry<Object>>[
                  /*PopupMenuItem(
                    value: 1,
                    child: Text("Settings"),
                  ),
                  PopupMenuDivider(
                    height: 10,
                  ),*/
                  PopupMenuItem(
                    value: 1,
                    child: Text("Log out"),
                    onTap: callback(PopMenuOptions.LOGOUT),
                  ),
                ]);
          },
          converter: (store) => (option) => () {
            switch (option) {
              case PopMenuOptions.LOGOUT:
                return store.dispatch(const LogoutAction());
            }
          }),
    );
  }
}


AppBar buildChatAppBar(BuildContext context, CommedTheme theme, String enterpriseName, String urlImage, int conversationId) {
  return AppBar(
    systemOverlayStyle:
    SystemUiOverlayStyle(statusBarColor: theme.appBarColor),
    backgroundColor: theme.appBarColor,
    title: StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => buildLogoAndEnterprise(theme, enterpriseName, urlImage, conversationId),
    ),
    actions: [
      buildSearchButton(theme, context),
      ProfileAppBarButton(theme: theme),
    ],
    elevation: 0,
  );
}

Row buildLogoAndEnterprise(CommedTheme theme, String enterpriseName, String urlImage, int conversationId) {
  return Row(
    children: [
      StoreConnector<AppState, VoidCallback>(
        converter: (sto) =>
            () => sto.dispatch(NavigateToEnterpriseDetail(conversationId)),
        builder: (con, callback) => InkWell(
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              urlImage,
            ),
          ),
          onTap: callback,
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        enterpriseName,
        style: TextStyle(color: theme.primary.textColor),
      )
    ],
  );
}

Widget buildSearchButton(CommedTheme theme, BuildContext context) {
  return StoreConnector<AppState, VoidCallback>(
      converter: (sto) =>
          () => sto.dispatch(const NavigateToNext(Routes.searcher)),
      builder: (cto, callback) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: IconButton(
            icon: Icon(Icons.search, color: theme.primary.textColor),
            onPressed: callback,
          )));
}