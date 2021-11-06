

import 'package:flutter/material.dart';
import 'package:flutter_app/login/utils/generic_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_app/widgets/fade_animation.dart';

class HeadLogin extends StatelessWidget {
  const HeadLogin({
   required this.func, Key? key,
  }) : super(key: key);

  final fromAppLocalization func;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 130.0, bottom: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(
                              func(AppLocalizations.of(context)!)
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontFamily: 'Market',
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ]),
      ),
    );
  }
}
