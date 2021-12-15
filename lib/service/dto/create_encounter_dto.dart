
import 'package:flutter_app/service/dto/encounter_dto.dart';
import 'package:flutter_app/service/dto/product_dto.dart';

import 'encounter_dto.dart';
import 'enterprise_dto.dart';

class CreateEncounterDTO {
  final EncounterDTO encounterDTO;
  final ProductDTO productDTO;
  final EnterpriseDTO enterpriseDTO;


  CreateEncounterDTO({
    required this.encounterDTO,
    required this.productDTO,
    required this.enterpriseDTO,
  });

  factory CreateEncounterDTO.fromJson(Map<String, dynamic> json) {
    return CreateEncounterDTO(
      encounterDTO: EncounterDTO.fromJson(json['encounter']),
      productDTO: ProductDTO.fromJson(json['product']),
      enterpriseDTO: EnterpriseDTO.fromJson(json['enterprise']),
    );
  }
}