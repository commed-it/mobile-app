import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/login/utils/box_decoration.dart';
import 'package:flutter_app/login/utils/generic_field.dart';
import 'package:flutter_app/login/utils/header.dart';
import 'package:flutter_app/login/widgets/generic_bottom.dart';
import 'package:flutter_app/login/widgets/login.dart';
import 'package:flutter_app/login/widgets/register.dart';
import 'package:flutter_app/views/register_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_app/widgets/fade_animation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'fields/username_password.dart';

class LoginView extends StatelessWidget {
  final store = Store(reducer, initialState: const LoginState(false, "", ""));

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.teal,
                  Colors.yellow.shade700,
                ]),
          ),
          child: Column(children: [
            HeadLogin(func: (x) => x.login_noun),
            BodyLogin(),
          ],)
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
    return Expanded(
      child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: StoreConnector<LoginState, bool>(builder: (context, isOnRegister) {
              return isOnRegister ? RegisterWidget(
                context: context,
              ): LoginWidget(context: context);
            }, converter: (store) => store.state.isOnRegister),
          )),
    );
  }
}
