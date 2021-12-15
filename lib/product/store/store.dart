import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

import 'actions.dart';

AppState listProductsReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case ToggleDescription:
      action = action as ToggleDescription;
      Product product = prev.products[action.productId]!;
      ProductContent content =
          product.content.copy(isAllShown: !product.content.isAllShown);
      Product newProduct = product.copy(content: content);
      prev.products[action.productId] = newProduct;
      return prev.copy(products: prev.products);
    default:
      return prev;
  }
}
