import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

import 'actions.dart';

AppState formalOfferReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case SetFormalOffers:
      var new_action = action as SetFormalOffers;
      return prev.copy(
        formalOffers: new_action.formalOffers,
      );
    default:
      return prev;
  }
}
