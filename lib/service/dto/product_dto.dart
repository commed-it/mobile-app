import 'package:flutter/cupertino.dart';
import 'package:flutter_app/widgets/carroussel.dart';

class ProductDTO {
  final int id;
  final int owner;
  final String title;
  final List<ImageContainerDTO> images;
  final String description;
  final double latitude;
  final double longitude;
  final List<TagDTO> tag;

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
      images: (json['images'] as List).map<ImageContainerDTO>((imgJson) => ImageContainerDTO.fromJson(imgJson)).toList(),
      description: json['description'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      tag: (json['tag'] as List).map<TagDTO>((tagJson) => TagDTO.fromJson(tagJson)).toList(),
    );
  }
}

class TagDTO {
  final String name;

  TagDTO({
    required this.name,
  });

  factory TagDTO.fromJson(Map<String, dynamic> json) {
    return TagDTO(name: json['name'] as String);
  }
}

class ImageContainerDTO {
  final int id;
  final String name;
  final String image;

  ImageContainerDTO({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ImageContainerDTO.fromJson(Map<String, dynamic> json) {
    return ImageContainerDTO(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }
}
