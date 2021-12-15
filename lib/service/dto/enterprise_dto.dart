class EnterpriseDTO {
  final int owner;
  final String NIF;
  final String name;
  final String contactInfo;
  final String description;
  final String profileImage;
  final String bannerImage;
  final String location;

  EnterpriseDTO(
      {required this.owner,
      required this.NIF,
      required this.name,
      required this.contactInfo,
      required this.description,
      required this.profileImage,
      required this.bannerImage,
      required this.location});

  factory EnterpriseDTO.fromJson(Map<String, dynamic> json) {
    return EnterpriseDTO(
      owner: json['owner'] as int,
      NIF: json['NIF'] as String,
      name: json['name'] as String,
      contactInfo: json['contactInfo'] as String,
      description: json['description'] as String,
      profileImage: json['profileImage'] as String,
      bannerImage: json['bannerImage'] as String,
      location: json['location'] as String,
    );
  }
}
