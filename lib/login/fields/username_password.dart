
import 'package:flutter/material.dart';
import 'package:flutter_app/login/utils/generic_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_app/widgets/fade_animation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../utils.dart';


class UsernameAndPasswordField extends StatelessWidget {
  const UsernameAndPasswordField({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        GenericField(context: context, icon: Icons.account_circle, func: (x) => x.username),
        GenericField(context: context, icon: Icons.password_outlined, func: (x) => x.password)
      ],
    );
  }
}
