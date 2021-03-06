import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/actions.dart';
import 'package:flutter_app/widgets/carroussel.dart';
import 'package:flutter_app/product/store/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'model/product.dart';

class HomeView extends StatelessWidget {
  final bool isAuthenticated;

  const HomeView({Key? key, bool? isAuthenticated})
      : isAuthenticated = isAuthenticated ?? true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (sto) => sto.state.theme,
      builder: (cte, theme) =>
          HomeBody(theme: theme, isAuthenticated: isAuthenticated),
    );
  }
}

class HomeBody extends StatelessWidget {
  final bool isAuthenticated;

  const HomeBody({
    Key? key,
    required this.theme,
    bool? isAuthenticated,
  })  : isAuthenticated = isAuthenticated ?? true,
        super(key: key);

  final CommedTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.background.color,
      child: StoreConnector<AppState, HashMap<int, Product>>(
        converter: (store) => store.state.products,
        builder: (context, products) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: products.values
                        .map((prod) => ProductItem(product: prod, theme: theme))
                        .fold(
                            [],
                            (value, element) => value
                              ..add(const Padding(
                                padding: EdgeInsets.only(top: 20),
                              ))
                              ..add(element)
                              ..add(const Padding(
                                padding: EdgeInsets.only(top: 20),
                              )))
                      ..add(
                        isAuthenticated
                            ? Container()
                            : const SizedBox(height: 70),
                      ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final CommedTheme theme;

  const ProductItem({Key? key, required this.product, required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenericCarrousel(
          imageContainer: product.content.imageContainer,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 20.0, top: 10),
          child: Column(
            children: [
              StoreConnector<AppState, VoidCallback>(
                  converter: (sto) =>
                      () => sto.dispatch(loadEnterprise(product.content.company.userID)),
                  builder: (cto, onPressedLogo) => GenericSummary.only(
                        ratio: 0.8,
                        image: NetworkImage(product.content.company.logoURI),
                        title: product.content.name,
                        subtitle: product.content.company.name,
                        onPressedLogo: onPressedLogo,
                        secondWidget: StoreConnector<AppState, bool>(
                          converter: (sto) => sto.state.loggedState == LoggedState.Logged,
                          builder: (cto, isLogged) =>
                              isLogged ? ChatButton(theme: theme, productId: product.id,) : Container(),
                        ),
                      )),
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
                        return SeeMoreButton(
                            product: product, callback: callback);
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

class ChatButton extends StatelessWidget {
  const ChatButton({
    Key? key,
    required this.theme,
    required this.productId,
  }) : super(key: key);

  final CommedTheme theme;
  final int productId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        StoreConnector<AppState, VoidCallback>(
          converter: (sto) => () => sto.dispatch(connectThunkChat(productId)),
          builder: (cto, onPressedChat) => ElevatedButton(
            onPressed: onPressedChat,
            child: Row(children: [
              Icon(Icons.chat_outlined),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  top: 18,
                  bottom: 18,
                ),
                child: Text(AppLocalizations.of(context)!.connect),
              ),
            ]),
            style: ElevatedButton.styleFrom(
              primary: theme.primary.color,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    Key? key,
    required this.product,
    required this.callback,
  }) : super(key: key);

  final Product product;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
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
  }
}
