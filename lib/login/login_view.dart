import 'package:flutter/material.dart';
import 'package:flutter_app/login/utils/header.dart';
import 'package:flutter_app/login/widgets/login.dart';
import 'package:flutter_app/login/widgets/register.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StoreConnector<AppState, CommedTheme>(
      converter: (store) => store.state.theme,
      builder: (ctx, theme) => Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.primary.color,
                theme.accent.color,
                theme.primary.color,
              ]),
        ),
        child: const _LoginExpanded(),
      ),
    ));
  }
}

class _LoginExpanded extends StatelessWidget {
  const _LoginExpanded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StoreConnector<AppState, bool>(
                      builder: (context, isOnRegister) => HeadLogin(
                          func: (x) =>
                              isOnRegister ? x.register : x.login_noun),
                      converter: (store) =>
                          store.state.loginViewState.isOnRegister),
                  const BodyLogin(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BodyLogin extends StatelessWidget {
  const BodyLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
        builder: (context, isOnRegister) {
          return isOnRegister
              ? RegisterWidget(
                  context: context,
                )
              : LoginWidget(context: context);
        },
        converter: (store) => store.state.loginViewState.isOnRegister);
  }
}
