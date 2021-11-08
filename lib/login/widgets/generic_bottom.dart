import 'package:flutter/material.dart';
import 'package:flutter_app/login/store/actions.dart';
import 'package:flutter_app/login/utils/generic_field.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/widgets/fade_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

FadeAnimation buildGenericBottomWidget(
    BuildContext context,
    fromAppLocalization elevatedFunc,
    fromAppLocalization outlinedFunc,
    double outWidth,
    IconData outIcon,
    AppAction action) {
  return FadeAnimation(
    1,
    Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          FormElevatedButton(context: context, func: elevatedFunc),
          const SizedBox(width: 15),
          buildOutlinedButton(
              context, outlinedFunc, outWidth, outIcon, action),
        ],
      ),
    ),
  );
}

Widget buildOutlinedButton(BuildContext context, fromAppLocalization func,
    double width, IconData icon, AppAction action) {
  return StoreConnector<AppState, VoidCallback>(
      builder: (context, callback) {
        return OutlinedButton.icon(
          icon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              icon,
              size: 18,
              color: Colors.teal,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          label: SizedBox(
            width: width,
            height: 50,
            child: Row(
              children: [
                Text(
                  func(AppLocalizations.of(context)!),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
          onPressed: callback,
        );
      },
      converter: (store) => () => store.dispatch(action));
}

class FormElevatedButton extends StatelessWidget {
  const FormElevatedButton({
    Key? key,
    required this.context,
    required this.func,
  }) : super(key: key);

  final BuildContext context;
  final fromAppLocalization func;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        primary: Colors.teal.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Container(
        width: 110,
        height: 45,
        alignment: Alignment.center,
        child: Text(
          func(AppLocalizations.of(context)!),
          style: const TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
