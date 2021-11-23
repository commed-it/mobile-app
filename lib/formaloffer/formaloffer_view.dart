import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model/formaloffer.dart';

Enterprise enterpriseA = Enterprise(
    "La Bicicleta",
    "NotADescription",
    "78099079A",
    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fthumbs.dreamstime.com%2Fb%2Flogo-semplice-della-tagliatella-piano-marchio-130436365.jpg&f=1&nofb=1",
    "contactInfo");

Enterprise enterpriseB = Enterprise(
    "Rodi",
    "NotADescription",
    "78099079A",
    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fofertes.ccoo.cat%2Fwp-content%2Fuploads%2Fsites%2F131%2F2019%2F05%2FRodi_Motor_Services_logo.jpg&f=1&nofb=1",
    "contactInfo");

List<FormalOffer> formalOffers = [
  FormalOffer(enterpriseA, "50 kg of chicken meat", 1, true),
  FormalOffer(enterpriseB, "Reparation of motors - 3242W", 2, false),
  FormalOffer(enterpriseB, "Inspection of 3242W", 1, true)
];

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
                  converter: (store) => () => store.dispatch(LambdaAction((s) =>
                      s.copy(
                          navigatorKey: s.navigatorKey
                            ..currentState!.pushNamed(Routes.chat)))),
                  builder: (ctx, callback) => Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Column(
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
                    ],
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
      converter: (sto) => () => sto.dispatch(NavigateToEnterpriseDetail(1)),
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
