import 'package:flutter/material.dart';
import 'package:flutter_app/chat/conversation/conversation_view.dart';
import 'package:flutter_app/login/login_view.dart';
import 'package:flutter_app/root/root_view.dart';
import 'package:flutter_app/searcher/searcher_view.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'enterprise/profile_view.dart';

void main() {
  final store = Store<AppState>((x, a) => appReducer(x, a),
      initialState: AppState.init(), middleware: [thunkMiddleware]);
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, GlobalKey<NavigatorState>>(
        converter: (store) => store.state.navigatorKey,
        builder: (context, navKey) {
          return StoreConnector<AppState, CommedTheme>(
              converter: (sto) => sto.state.theme,
              builder: (cto, theme) => MaterialApp(
                    navigatorKey: navKey,
                    debugShowCheckedModeBanner: false,
                    title: 'Commed',
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en', ''),
                      Locale('es', ''),
                    ],
                    initialRoute: Routes.home,
                    routes: {
                      Routes.home: (c) => const RootWidget(),
                      Routes.login: (c) => const LoginView(),
                      Routes.chat: (c) => MockConversation(theme: theme),
                      Routes.enterprise: (c) => const EnterpriseView(),
                      Routes.searcher: (c) => SearcherView()
                    },
                    home: const RootWidget(),
                  ));
        },
      ),
    );
  }
}
