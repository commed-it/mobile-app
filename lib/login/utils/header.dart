import 'package:flutter/material.dart';
import 'package:flutter_app/login/utils/generic_field.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/fade_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HeadLogin extends StatelessWidget {
  const HeadLogin({
    required this.func,
    Key? key,
  }) : super(key: key);

  final fromAppLocalization func;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
        child: Stack(
            children: [
              const BackButton(),
              Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: FadeAnimation(
                        1,
                        Column(
                          children: [
                            Image.asset(
                              'assets/logo-white.png',
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                            StoreConnector<AppState, CommedTheme>(
                                builder: (ctx, theme) =>
                                    Text(
                                      func(AppLocalizations.of(context)!).toUpperCase(),
                                      style: TextStyle(
                                        color: theme.primary.textColor,
                                        fontSize: 50,
                                        fontFamily: 'Market',
                                      ),
                                    ),

                                converter: (s) => s.state.theme)
                         ],
                        ),
                      ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
