import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/widgets/carroussel.dart';

import 'actions.dart';

AppState listProductsReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case SetProductList:
      action = action as SetProductList;
      List<Product> products = action.products;
      return prev.copy(products: products);
    default:
      return prev;
  }
}
