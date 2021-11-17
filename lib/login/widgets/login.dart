import 'package:flutter/material.dart';
import 'package:flutter_app/auth/actions.dart';
import 'package:flutter_app/login/store/actions.dart';
import 'package:flutter_app/login/utils/generic_field.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'generic_bottom.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GenericField(
            context: context,
            icon: Icons.account_circle,
            func: (x) => x.username,
            newAction: (v) => SetUsernameAction(v),
            converter: (s) => s.state.loginViewState.username
        ),
        GenericField(
            context: context,
            icon: Icons.password_outlined,
            func: (x) => x.password,
            newAction: (v) => SetPasswordAction(v),
            converter: (s) => s.state.loginViewState.password
        ),
        const SizedBox(
          height: 10,
        ),
        StoreConnector<AppState, VoidCallback>(converter: (sto) => () => sto.dispatch(const ToggleAuthToken(true)),
            builder: (cto, callback) =>
                buildGenericBottomWidget(
                    context,
                        (x) => x.login_verb,
                        (x) => x.register_switch,
                    100,
                    Icons.add,
                    const TurnOnRegisterAction(),
                    callback
                )),
        const SizedBox(height: 20),
      ],
    );
  }

  Divider buildDivider() {
    return const Divider(
      indent: 30,
      endIndent: 30,
      thickness: 1.0,
    );
  }
}
