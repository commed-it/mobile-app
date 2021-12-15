import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/auth/actions.dart';
import 'package:flutter_app/chat/store/actions.dart';
import 'package:flutter_app/searcher/model.dart';
import 'package:flutter_app/service/actions.dart';
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
      searchActionBuilder(theme),
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
      searchActionBuilder(theme),
      ProfileAppBarButton(theme: theme),
    ],
    elevation: 0,
  );
}

Padding searchActionBuilder(CommedTheme theme) {
  return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            buildTextSearched(theme),
            StoreConnector<AppState, VoidCallback>(
              converter: (store) =>
                  () => store.dispatch(const NavigateToNext(Routes.searcher)),
              builder: (ctx, callback) => IconButton(
                icon: Icon(Icons.search, color: theme.primary.textColor),
                onPressed: callback,
              ),
            ),
          ],
        ));
}

Widget buildTextSearched(CommedTheme theme) {
  return StoreConnector<AppState, Searcher>(
    converter: (sto) => sto.state.searcher,
    builder: (cto, searcher) => Padding(
      padding: EdgeInsets.only(right: 10),
      child: searcher.hasSearched ? Row(
        children: [
          StoreConnector<AppState, VoidCallback>(
            converter: (store) => () => store.dispatch(clearSearchAndReload()),
            builder: (ctx, callback) => IconButton(
              icon: Icon(Icons.delete_forever_outlined,
                  color: theme.primary.textColor),
              onPressed: callback,
            ),
          ),
          Text(searcher.textSearched),
        ],
      ) : Container(),
    ),
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
                    return store.dispatch(logoutThunk());
                }
              }),
    );
  }
}

AppBar buildChatAppBar(
    BuildContext context,
    CommedTheme theme,
    String enterpriseName,
    String urlImage,
    String conversationId,
    int enterpriseId) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: theme.appBarColor),
    backgroundColor: theme.appBarColor,
    title: StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => buildLogoAndEnterprise(
          theme, enterpriseName, urlImage, conversationId, enterpriseId),
    ),
    actions: [
      buildSearchButton(theme, context),
      ProfileAppBarButton(theme: theme),
    ],
    elevation: 10,
  );
}

Row buildLogoAndEnterprise(CommedTheme theme, String enterpriseName,
    String urlImage, String conversationId, int enterpriseId) {
  return Row(
    children: [
      StoreConnector<AppState, VoidCallback>(
        converter: (sto) => () => sto.dispatch(loadEnterprise(enterpriseId)),
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
