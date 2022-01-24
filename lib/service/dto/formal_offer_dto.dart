
class FormalOfferDTO {
  final String encounterId;
  final int version;
  final String contract;
  final String pdfURL;
  final int formalOfferId;

  FormalOfferDTO({
    required this.encounterId,
    required this.version,
    required this.contract,
    required this.pdfURL,
    required this.formalOfferId,
  });

  factory FormalOfferDTO.fromJson(Map<String, dynamic> json) {
    return FormalOfferDTO(
      encounterId: json['encounterId'] as String,
      version: json['version'] as int,
      contract: json['contract'] as String,
      pdfURL: json['pdf'] as String,
      formalOfferId: json['id'] as int,
    );
  }
}
