
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/formaloffer/model/formaloffer.dart';
import 'package:flutter_app/store/actions.dart';

@immutable
class SetFormalOffers extends AppAction {
  List<FormalOffer> formalOffers;
  SetFormalOffers(this.formalOffers);
}
