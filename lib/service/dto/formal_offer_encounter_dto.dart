
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/service/dto/formal_offer_dto.dart';
import 'package:flutter_app/service/dto/product_dto.dart';

import 'encounter_dto.dart';
import 'enterprise_dto.dart';

class FormalOfferEncounterDTO {
  final FormalOfferDTO formalOffer;
  final EncounterDTO encounter;
  final ProductDTO product;
  final EnterpriseDTO theOtherClient;


  FormalOfferEncounterDTO({
    required this.formalOffer,
    required this.encounter,
    required this.product,
    required this.theOtherClient,
  });

  factory FormalOfferEncounterDTO.fromJson(Map<String, dynamic> json) {
    return FormalOfferEncounterDTO(
      formalOffer: FormalOfferDTO.fromJson(json['formalOffer']),
      encounter: EncounterDTO.fromJson(json['encounter']),
      product: ProductDTO.fromJson(json['product']),
      theOtherClient: EnterpriseDTO.fromJson(json['theOtherClient']),
    );
  }
}
