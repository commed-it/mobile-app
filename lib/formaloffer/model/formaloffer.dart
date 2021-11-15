import 'package:flutter/cupertino.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';

@immutable
class FormalOffer {
  final Enterprise enterprise;
  final String productContent;
  final int numVersion;
  final bool isSigned;

  const FormalOffer(
      this.enterprise, this.productContent, this.numVersion, this.isSigned);
}
