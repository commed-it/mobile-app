class ProductDTO {
  final int id;
  final int owner;
  final String title;
  final List<String> images;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> tag;

  ProductDTO(
      {required this.id,
      required this.owner,
      required this.title,
      required this.images,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.tag});

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      id: json['id'] as int,
      owner: json['owner'] as int,
      title: json['title'] as String,
      images: json['images'].cast<String>(),
      description: json['description'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      tag: json['tag'].cast<String>(),
    );
  }
}
