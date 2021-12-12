import 'package:flutter/cupertino.dart';
import 'package:flutter_app/service/dto/product_dto.dart';
import 'package:flutter_app/widgets/carroussel.dart';

class SearchDTO {
  final LocationDTO locationDTO;
  final List<TagDTO> tag;

  SearchDTO(
      {required this.locationDTO,
        required this.tag});

  factory SearchDTO.fromJson(Map<String, dynamic> json) {
    return SearchDTO(
      locationDTO: LocationDTO.fromJson(json['location']),
      tag: (json['tags'] as List).map<TagDTO>((tagJson) => TagDTO.fromJson(tagJson)).toList(),
    );
  }
}

class LocationDTO {
  final double longitude;
  final double latitude;
  final double distance;

  LocationDTO({
    required this.longitude,
    required this.latitude,
    required this.distance
  });

  factory LocationDTO.fromJson(Map<String, dynamic> json) {
    return LocationDTO(longitude: json['longitud'] as double,
    latitude: json['latitude'] as double,
    distance: json['distance_km'] as double);
  }
}

