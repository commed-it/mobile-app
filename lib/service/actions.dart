import 'dart:collection';

import 'package:flutter_app/auth/actions.dart';
import 'package:flutter_app/chat/models.dart';
import 'package:flutter_app/chat/store/actions.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/formaloffer/model/formaloffer.dart';
import 'package:flutter_app/formaloffer/store/actions.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> reloadProducts() {
  return (Store<AppState> store) async {
    final HashMap<int, Product> products =
        await store.state.commedMiddleware.getProducts();
    store.dispatch(SetProductList(products));
  };
}

ThunkAction<AppState> loadEnterprise(int userId) {
  return (Store<AppState> store) async {
    final Enterprise enterprise =
        await store.state.commedMiddleware.getEnterprise(userId);
    store.dispatch(NavigateToEnterpriseDetail(enterprise));
  };
}

ThunkAction<AppState> loginThunkAction(String username, String password) {
  return (Store<AppState> store) async {
    String? tok = await store.state.commedMiddleware.login(username, password);
    store.dispatch(ToggleAuthToken(tok != null));
    final Enterprise enterprise =
        await store.state.commedMiddleware.getMyEnterprise();
    store.dispatch(setMyEnterpriseDetail(enterprise));
  };
}

ThunkAction<AppState> registerThunkAction(LoginState loginViewState) {
  return (Store<AppState> store) async {
    String? tok = await store.state.commedMiddleware.register(loginViewState);
    final Enterprise enterprise =
        await store.state.commedMiddleware.createEnterprise(loginViewState);
    store.dispatch(ToggleAuthToken(tok != null));
    store.dispatch(setMyEnterpriseDetail(enterprise));
  };
}

ThunkAction<AppState> loadMyFormalOffers() {
  return (Store<AppState> store) async {
    List<FormalOffer> formalOffers =
        await store.state.commedMiddleware.getMyFormalOffersEncounter();
    store.dispatch(SetFormalOffers(formalOffers));
  };
}

ThunkAction<AppState> loadListChat() {
  return (Store<AppState> store) async {
    List<ChatItemModel> chatModels = await store.state.commedMiddleware.getListChat();
    store.dispatch(SetListChat(chatModels));
  };
}

ThunkAction<AppState> submitSearch(String text) {
  return (Store<AppState> store) async {
    final HashMap<int, Product> products =
        await store.state.commedMiddleware.getProducts();
    store.dispatch(SetProductList(products));
    store.dispatch(NavigateBack());
  };
}

class SetProductList extends AppAction {
  final HashMap<int, Product> products;

  const SetProductList(this.products);
}

