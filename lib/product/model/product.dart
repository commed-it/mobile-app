import 'package:flutter_app/generic/carrousel/exported.dart';

class Product {
  final ImageContainer imageContainer;
  final String name;
  final String description;
  final bool isAllShown;
  final CompanySmallDetail company;

  Product(this.imageContainer, this.name, this.description, this.isAllShown, this.company);
}

class CompanySmallDetail {
  final String logoURI;
  final String name;

  CompanySmallDetail(this.logoURI, this.name);
}
