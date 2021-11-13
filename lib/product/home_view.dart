import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generic/carrousel/exported.dart';
import 'package:flutter_app/product/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'model/product.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (sto) => sto.state.theme,
      builder: (cte, theme) => Container(
        color: theme.background.color,
        child: StoreConnector<AppState, List<Product>>(
          converter: (store) => store.state.products,
          builder: (context, products) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: products
                          .map((prod) => ProductItem(product: prod))
                          .fold(
                              [],
                              (value, element) => value
                                ..add(const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                ))
                                ..add(element)
                                ..add(const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                ))),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenericCarrousel(
          imageContainer: product.content.imageContainer,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 40.0, top: 10),
          child: Column(
            children: [
              GenericSummary.only(
                ratio: 0.8,
                image: NetworkImage(product.content.company.logoURI),
                title: product.content.name,
                subtitle: product.content.company.name,
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product.content.description,
                      overflow: product.content.isAllShown
                          ? null
                          : TextOverflow.ellipsis,
                      maxLines: product.content.isAllShown ? null : 2,
                      softWrap: product.content.isAllShown,
                    ),
                    StoreConnector<AppState, VoidCallback>(
                      converter: (ste) =>
                          () => ste.dispatch(ToggleDescription(product.id)),
                      builder: (cte, callback) {
                        return InkWell(
                          child: StoreConnector<AppState, CommedTheme>(
                            converter: (sto) => sto.state.theme,
                            builder: (context, theme) {
                              return Text(
                                product.content.isAllShown
                                    ? AppLocalizations.of(context)!.see_less
                                    : AppLocalizations.of(context)!.see_more,
                                style: TextStyle(color: theme.link.textColor),
                              );
                            },
                          ),
                          onTap: callback,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
