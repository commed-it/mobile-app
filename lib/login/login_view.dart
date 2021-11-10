import 'package:flutter/material.dart';
import 'package:flutter_app/login/utils/header.dart';
import 'package:flutter_app/login/widgets/login.dart';
import 'package:flutter_app/login/widgets/register.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.teal,
                Colors.yellow.shade700,
              ]),
        ),
        child: Expanded(
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
                  BodyLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
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
                converter: (store) => store.state.loginViewState.isOnRegister
    );
  }
}
