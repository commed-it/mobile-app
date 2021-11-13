import 'package:flutter/cupertino.dart';

@immutable
class Enterprise {
  final String name;
  final String description;
  final String nif;
  final String urlLogo;
  final String contactInfo;

  Enterprise(
      this.name, this.description, this.nif, this.urlLogo, this.contactInfo);

  Enterprise copy(
          {String? name,
          String? description,
          String? nif,
          String? urlLogo,
          String? contactInfo}) =>
      Enterprise(
          name ?? this.name,
          description ?? this.description,
          nif ?? this.nif,
          urlLogo ?? this.urlLogo,
          contactInfo ?? this.contactInfo);

  const Enterprise.init() :
      name = "", description = "", nif = "", urlLogo= "", contactInfo ="";

}
