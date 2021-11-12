import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generic/carrousel/exported.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../constants.dart';
import 'model/product.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: StoreConnector<AppState, List<Product>>(
        converter: (store) => store.state.products,
        builder: (context, products) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                    products.map((prod) => ProductItem(product: prod)).fold(
                        [],
                            (value, element) =>
                        value..add(const Padding(
                          padding: EdgeInsets.only(top: 20),
                        ))..add(element)..add(const Padding(
                          padding: EdgeInsets.only(top: 20),
                        ))),
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

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenericCarrousel(
          imageContainer: product.imageContainer,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 40.0, top: 10),
          child: Column(
            children: [
              GenericSummary.only(
                ratio: 0.8,
                image: NetworkImage(product.company.logoURI),
                title: product.name,
                subtitle: product.company.name,
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product.description,
                      overflow: product.isAllShown ? null : TextOverflow
                          .ellipsis,
                      maxLines: product.isAllShown ? null : 2,
                      softWrap: product.isAllShown,
                    ),
                    product.isAllShown ? Container() : InkWell(
                        child: Text("Hi"),
                    onTap: () {
                          print("TAPTAP");
                    },)
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
