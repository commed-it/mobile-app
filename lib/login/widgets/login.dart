import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/actions.dart';
import 'package:flutter_app/login/utils/generic_field.dart';

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
            func: (x) => x.username),
        GenericField(
            context: context,
            icon: Icons.password_outlined,
            func: (x) => x.password),
        const SizedBox(
          height: 10,
        ),
        buildGenericBottomWidget(context, (x) => x.login_verb,
            (x) => x.register_switch, 100, Icons.add, const TurnOnRegisterAction()),
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
