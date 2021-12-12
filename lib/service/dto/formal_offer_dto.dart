
class FormalOfferDTO {
  final String encounterId;
  final int version;
  final String contract;
  final String? signedPDF;

  FormalOfferDTO({
    required this.encounterId,
    required this.version,
    required this.contract,
    required this.signedPDF,
  });

  factory FormalOfferDTO.fromJson(Map<String, dynamic> json) {
    return FormalOfferDTO(
      encounterId: json['encounterId'] as String,
      version: json['version'] as int,
      contract: json['contract'] as String,
      signedPDF: json['signedPDF'] as String?,
    );
  }
}
