import 'package:flutter_app/widgets/carroussel.dart';

class Product {
  final int id;
  final ProductContent content;

  Product(this.id, this.content);

  Product copy({int? id, ProductContent? content}) =>
      Product(id ?? this.id, content ?? this.content);
}

class ProductContent {
  final ImageContainer imageContainer;
  final String name;
  final String description;
  final bool isAllShown;
  final CompanySmallDetail company;

  ProductContent(this.imageContainer, this.name, this.description,
      this.isAllShown, this.company);

  ProductContent copy(
          {ImageContainer? imageContainer,
          String? name,
          String? description,
          bool? isAllShown,
          CompanySmallDetail? company}) =>
      ProductContent(
          imageContainer ?? this.imageContainer,
          name ?? this.name,
          description ?? this.description,
          isAllShown ?? this.isAllShown,
          company ?? this.company);
}

class CompanySmallDetail {
  final String logoURI;
  final String name;

  CompanySmallDetail(this.logoURI, this.name);

  CompanySmallDetail copy({String? logoURI, String? name}) =>
      CompanySmallDetail(logoURI ?? this.logoURI, name ?? this.name);
}
