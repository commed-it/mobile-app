import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/service/dto/product_dto.dart';
import 'package:flutter_app/service/middleware_service.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'commed_api.dart';

ThunkAction<AppState> reloadProducts() {
  return (Store<AppState> store) async {
    final List<Product> products = await CommedMiddleware().getProducts();

    store.dispatch(SetProductList(products));
  };
}

class SetProductList extends AppAction {
  final List<Product> products;
  const SetProductList(this.products);
}
