import 'package:flutter/material.dart';
import 'package:flutter_app/chat/conversation/conversation_view.dart';
import 'package:flutter_app/login/login_view.dart';
import 'package:flutter_app/root/root_view.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store<AppState>((x, a) => appReducer(x, a),
      initialState: AppState.init());

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, GlobalKey<NavigatorState>>(
        converter : (store) => store.state.navigatorKey,
        builder: (context, navKey) {
          return MaterialApp(
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
              Routes.login: (c) => LoginView(),
              Routes.chat: (c) => MockConversation(),
            },
            home: const RootWidget(),
          );
        },
      ),
    );
  }
}
