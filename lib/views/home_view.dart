import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        child: Center(
            child: Stack(
          children: [
            Text(AppLocalizations.of(context)!.helloWorld),
          ],
        )));
  }
}
