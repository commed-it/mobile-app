class EncounterDTO {
  final String id;
  final int client;
  final int product;

  EncounterDTO({
    required this.id,
    required this.client,
    required this.product,
  });

  factory EncounterDTO.fromJson(Map<String, dynamic> json) {
    return EncounterDTO(
      id: json['id'] as String,
      client: json['client'] as int,
      product: json['product'] as int,
    );
  }
}
