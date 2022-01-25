import 'package:flutter/material.dart';
import 'package:flutter_app/service/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PopUpSign extends StatelessWidget {
  final String name;
  final int formalOfferId;
  final String urlPDF;

  const PopUpSign(
      {Key? key,
      required this.name,
      required this.formalOfferId,
      required this.urlPDF})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (sto) => sto.state.theme,
      builder: (cto, theme) => AlertDialog(
        title: Text(name),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.question_sign),
            ]),
        actions: [
          Container(
            child: StoreConnector<AppState, VoidCallback>(
              converter: (sto) => () => sto.dispatch(NavigateBack()),
              builder: (cto, cancelCallback) => OutlinedButton(
                onPressed: cancelCallback,
                child: Text("No"),
                style: ElevatedButton.styleFrom(
                  primary: theme.background.color,
                  onPrimary: theme.primary.color,
                ),
              ),
            ),
          ),
          Container(
            child: StoreConnector<AppState, VoidCallback>(
              converter: (sto) =>
                  () => sto.dispatch(signCall(this.formalOfferId)),
              builder: (cto, signCallback) => OutlinedButton(
                onPressed: () {
                  signCallback();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(cto)!.email_has_sent),
                      duration: const Duration(milliseconds: 10000),
                      width: 280.0,
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        bottom: 20,
                        top: 20,
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                },
                child: Text("Yes"),
                style: ElevatedButton.styleFrom(
                  primary: theme.primary.color,
                  onPrimary: theme.background.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
