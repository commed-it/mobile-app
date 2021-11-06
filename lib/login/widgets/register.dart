import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/actions.dart';
import 'package:flutter_app/login/utils/generic_field.dart';

import 'generic_bottom.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({
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
            icon: Icons.work_outline,
            func: (x) => x.company_name),
        GenericField(
            context: context, icon: Icons.article_outlined, func: (x) => x.nif),
        buildDivider(),
        GenericField(
            context: context,
            icon: Icons.account_circle,
            func: (x) => x.username),
        GenericField(
            context: context,
            icon: Icons.password_outlined,
            func: (x) => x.password),
        GenericField(
            context: context,
            icon: Icons.password_outlined,
            func: (x) => x.repeat_password),
        buildDivider(),
        GenericField(
            context: context,
            icon: Icons.alternate_email,
            func: (x) => x.email),
        GenericField(
            context: context, icon: Icons.local_phone, func: (x) => x.contact),
        const SizedBox(
          height: 10,
        ),
        buildGenericBottomWidget(context, (x) => x.register,
            (x) => x.login_switch, 170, Icons.remove, const TurnOnLoginAction()),
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
