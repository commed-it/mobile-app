import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/actions.dart';
import 'package:flutter_app/login/utils/generic_field.dart';
import 'package:flutter_app/service/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'generic_bottom.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String?>(
      converter: (sto) => sto.state.loggedState == LoggedState.CouldntLog
          ? AppLocalizations.of(context)!.loginError
          : null,
      builder: (cto, errorText) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GenericField(
            context: context,
            icon: Icons.work_outline,
            translator: (x) => x.company_name,
            newAction: (v) => SetCompanyAction(v),
            converter: (s) => s.state.loginViewState.company,
            errorText: errorText,
          ),
          GenericField(
            context: context,
            icon: Icons.article_outlined,
            translator: (x) => x.nif,
            newAction: (v) => SetNifAction(v),
            converter: (s) => s.state.loginViewState.nif,
            errorText: errorText,
          ),
          buildDivider(),
          GenericField(
            context: context,
            icon: Icons.account_circle,
            translator: (x) => x.username,
            newAction: (v) => SetUsernameAction(v),
            converter: (s) => s.state.loginViewState.username,
            errorText: errorText,

          ),
          GenericField(
            context: context,
            icon: Icons.password_outlined,
            translator: (x) => x.password,
            newAction: (v) => SetPasswordAction(v),
            converter: (s) => s.state.loginViewState.password,
            errorText: errorText,

          ),
          GenericField(
            context: context,
            icon: Icons.password_outlined,
            translator: (x) => x.repeat_password,
            newAction: (v) => SetRepeatPasswordAction(v),
            converter: (s) => s.state.loginViewState.repeatPassword,
            errorText: errorText,

          ),
          buildDivider(),
          GenericField(
            context: context,
            icon: Icons.alternate_email,
            translator: (x) => x.email,
            newAction: (v) => SetEmailAction(v),
            converter: (s) => s.state.loginViewState.email,
            errorText: errorText,

          ),
          GenericField(
            context: context,
            icon: Icons.local_phone,
            translator: (x) => x.contact,
            newAction: (v) => SetContactAction(v),
            converter: (s) => s.state.loginViewState.contact,
            errorText: errorText,

          ),
          const SizedBox(
            height: 10,
          ),
          StoreConnector<AppState, VoidCallback>(
            converter: (sto) => () =>
                sto.dispatch(registerThunkAction(sto.state.loginViewState)),
            builder: (cto, callback) => buildGenericBottomWidget(
                context,
                (x) => x.register,
                (x) => x.login_switch,
                170,
                Icons.remove,
                const TurnOnLoginAction(),
                callback),
          ),
          const SizedBox(height: 20),
        ],
      ),
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
