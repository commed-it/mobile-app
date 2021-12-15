import 'package:flutter/material.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/widgets/fade_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/src/store.dart';

import 'box_decoration.dart';

typedef String fromAppLocalization(AppLocalizations x);

typedef void DipatchAction(String a);

typedef String GetString(Store<AppState> s);

class GenericFieldController {
  final DipatchAction dipatchAction;
  final String value;

  GenericFieldController(this.dipatchAction, this.value);
}

typedef String Converter(Store<AppState> store);

typedef AppAction NewAction(String value);

class GenericField extends StatelessWidget {

  const GenericField({
    Key? key,
    required this.context,
    required this.icon,
    required this.translator,
    required this.converter,
    required this.newAction,
    this.errorText
  }) : super(key: key);

  final BuildContext context;
  final IconData icon;
  final fromAppLocalization translator;
  final Converter converter;
  final NewAction newAction;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      // username
      2,
      Container(
          width: double.infinity,
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: fieldBoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: StoreConnector<AppState, GenericFieldController> (
                    converter: (store) => GenericFieldController((v) => store.dispatch(newAction(v)), converter(store)),
                    builder: (ctx, count) => TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      label: Text(" " + translator(AppLocalizations.of(context)!)),
                      border: InputBorder.none,
                      errorText: errorText,
                    ),
                    initialValue: count.value,
                      onChanged: (value)  => {
                        count.dipatchAction(value)
                      },
                  )
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
