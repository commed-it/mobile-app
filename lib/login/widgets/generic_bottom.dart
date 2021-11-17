import 'package:flutter/material.dart';
import 'package:flutter_app/login/utils/generic_field.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/fade_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

FadeAnimation buildGenericBottomWidget(
    BuildContext context,
    fromAppLocalization elevatedFunc,
    fromAppLocalization outlinedFunc,
    double outWidth,
    IconData outIcon,
    AppAction action,
    VoidCallback elevatedCallback) {
  return FadeAnimation(
    1,
    Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          FormElevatedButton(context: context, func: elevatedFunc, callbackButton: elevatedCallback,),
          const SizedBox(width: 15),
          buildOutlinedButton(context, outlinedFunc, outWidth, outIcon, action),
        ],
      ),
    ),
  );
}

class VoidCallbackAndTheme {
  final VoidCallback func;
  final CommedTheme theme;

  VoidCallbackAndTheme(this.func, this.theme);
}

Widget buildOutlinedButton(BuildContext context, fromAppLocalization func,
    double width, IconData icon, AppAction action) {
  return StoreConnector<AppState, VoidCallbackAndTheme>(
      builder: (context, callback) {
        return OutlinedButton.icon(
          icon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              icon,
              size: 18,
              color: callback.theme.primary.color,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            primary: callback.theme.primary.textColor,
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
                  style: TextStyle(
                    fontSize: 20,
                    color: callback.theme.primary.color,
                  ),
                ),
              ],
            ),
          ),
          onPressed: callback.func,
        );
      },
      converter: (store) => VoidCallbackAndTheme(
          () => store.dispatch(action), store.state.theme));
}

class FormElevatedButton extends StatelessWidget {
  final VoidCallback callbackButton;

  const FormElevatedButton({
    Key? key,
    required this.context,
    required this.func,
    required this.callbackButton,
  }) : super(key: key);

  final BuildContext context;
  final fromAppLocalization func;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      builder: (ctx, theme) => ElevatedButton(
        onPressed: callbackButton,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          primary: theme.primary.color,
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
            style: TextStyle(
              fontFamily: 'RobotoMono',
              fontSize: 20,
              color: theme.primary.textColor,
            ),
          ),
        ),
      ),
      converter: (s) => s.state.theme,
    );
  }
}
