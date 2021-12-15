import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/service/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model/formaloffer.dart';

class FormalOffersView extends StatelessWidget {
  const FormalOffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (sto) => sto.state.theme,
      builder: (cto, theme) => Column(
        children: [
          Expanded(
            child: Container(
              color: theme.background.color,
              child: SingleChildScrollView(
                child: StoreConnector<AppState, VoidCallback>(
                  converter: (sto) => () => sto.dispatch(loadMyFormalOffers()),
                  builder: (ctx, callbackThunk) => StoreConnector<AppState, VoidCallback>(
                    converter: (store) => () => store.dispatch(LambdaAction((s) =>
                        s.copy(
                            navigatorKey: s.navigatorKey
                              ..currentState!.pushNamed(Routes.chat)))),
                    builder: (ctx, callback) => Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        StoreConnector<AppState, List<FormalOffer>>(
                          onInit: (sto) => callbackThunk(),
                          converter: (sto) => sto.state.formalOffers,
                          builder: (ctx, formalOffers) => Column(
                            children: formalOffers
                                .map((formalOffer) => Column(
                                      children: [
                                        FormalOfferItem(
                                            formalOffer: formalOffer,
                                            callback: callback,
                                            theme: theme),
                                        const ListDivider(),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormalOfferItem extends StatelessWidget {
  const FormalOfferItem({
    Key? key,
    required this.formalOffer,
    required this.callback,
    required this.theme,
  }) : super(key: key);

  final FormalOffer formalOffer;
  final VoidCallback callback;
  final CommedTheme theme;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (sto) => () => sto.dispatch(loadEnterprise(1)), // TODO: TODO
      builder: (c, callbackLogo) => GenSummaryButton.only(
        ratio: 0.8,
        image: NetworkImage(formalOffer.enterprise.urlLogo),
        title: formalOffer.productContent,
        subtitle: formalOffer.enterprise.name,
        onPressed: callback,
        onPressedLogo: callbackLogo,
        secondWidget: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              AppLocalizations.of(context)!.num_version + formalOffer.numVersion.toString(),
              style: TextStyle(
                color: theme.accent.textColor,
                fontStyle: FontStyle.italic,
              ),
            ),
            SignBadge(formalOffer: formalOffer, theme: theme),
          ],
        ),
      ),
    );
  }
}

class SignBadge extends StatelessWidget {
  const SignBadge({
    Key? key,
    required this.formalOffer,
    required this.theme,
  }) : super(key: key);

  final FormalOffer formalOffer;
  final CommedTheme theme;

  @override
  Widget build(BuildContext context) {
    return formalOffer.isSigned
        ? Chip(
            padding: EdgeInsets.all(0),
            backgroundColor: theme.primary.color,
            label: Text(AppLocalizations.of(context)!.signed.toUpperCase(),
                style: TextStyle(color: theme.primary.textColor)),
          )
        : Chip(
            padding: EdgeInsets.all(0),
            backgroundColor: theme.accent.color,
            label: Text(AppLocalizations.of(context)!.not_signed.toUpperCase(),
                style: TextStyle(color: theme.accent.textColor)),
          );
  }
}
