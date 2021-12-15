import 'package:flutter_app/service/dto/product_dto.dart';

import 'encounter_dto.dart';
import 'enterprise_dto.dart';

class ListChatDTO {
  final EncounterDTO encounter;
  final ProductDTO product;
  final EnterpriseDTO theOtherClient;

  ListChatDTO({
    required this.encounter,
    required this.product,
    required this.theOtherClient,
  });

  factory ListChatDTO.fromJson(Map<String, dynamic> json) {
    return ListChatDTO(
      encounter: EncounterDTO.fromJson(json['encounter']),
      product: ProductDTO.fromJson(json['product']),
      theOtherClient: EnterpriseDTO.fromJson(json['theOtherClient']),
    );
  }
}