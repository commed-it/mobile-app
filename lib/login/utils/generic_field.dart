
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_app/widgets/fade_animation.dart';

import 'box_decoration.dart';


typedef String fromAppLocalization(AppLocalizations x);
class GenericField extends StatelessWidget {
  const GenericField({
    Key? key,
    required this.context,
    required this.icon,
    required this.func,
  }) : super(key: key);

  final BuildContext context;
  final IconData icon;
  final fromAppLocalization func;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation( // username
      2,
      Container(
          width: double.infinity,
          height: 70,
          margin: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 20),
          padding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 5),
          decoration: fieldBoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      label: Text(" " +
                          func(AppLocalizations.of(context)!)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
