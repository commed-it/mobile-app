import 'package:flutter/material.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'model/formaloffer.dart';

Enterprise enterpriseA = Enterprise(
    "La Bicicleta",
    "NotADescription",
    "78099079A",
    "https://instagram.fbcn5-1.fna.fbcdn.net/v/t51.2885-19/s150x150/25024378_169126683844186_21293180838215680_n.jpg?_nc_ht=instagram.fbcn5-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=jVg3B7QJJo0AX9zxkms&edm=ABfd0MgBAAAA&ccb=7-4&oh=4731660aa270050f2805bb12fd3a2a97&oe=6196859C&_nc_sid=7bff83",
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
                                    StoreConnector<AppState, VoidCallback>(
                                      converter: (sto) => () => sto
                                          .dispatch(NavigateToEnterpriseDetail(1)),
                                      builder: (c, callbackLogo) =>
                                          GenSummaryButton.only(
                                        ratio: 0.8,
                                        image: NetworkImage(
                                            formalOffer.enterprise.urlLogo),
                                        title: formalOffer.enterprise.name,
                                        subtitle: formalOffer.productContent,
                                        onPressed: callback,
                                        onPressedLogo: callbackLogo,
                                        secondWidget: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "num version: " +
                                                  formalOffer.numVersion
                                                      .toString(),
                                              style: TextStyle(
                                                color: theme.accent.textColor,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            formalOffer.isSigned
                                                ? Chip(
                                                    padding: EdgeInsets.all(0),
                                                    backgroundColor:
                                                        theme.primary.color,
                                                    label: Text(
                                                        'signed'.toUpperCase(),
                                                        style: TextStyle(
                                                            color: theme.primary
                                                                .textColor)),
                                                  )
                                                : Chip(
                                                    padding: EdgeInsets.all(0),
                                                    backgroundColor:
                                                        theme.accent.color,
                                                    label: Text(
                                                        'not signed'
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: theme.accent
                                                                .textColor)),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
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
