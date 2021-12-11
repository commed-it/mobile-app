import 'package:flutter/cupertino.dart';
import 'package:flutter_app/service/dto/enterprise_dto.dart';

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

  const Enterprise.init()
      : name = "La Bicicleta",
        description =
            "El restaurante ocupa la planta baja del Casal organizado en dos comedores: El comedor Do Carrasca, con cabida para treinta comensales, nos ofrece posada al abrigo de su gran chimenea. El comedor Da Paloma está pensado para albergar pequeñas celebraciones o comidas de empresa, con una capacidad de hasta ochenta personas. Además dispone de proyector y pantalla lo que posibilita su utilización para presentaciones y eventos similares. El local, inaugurado en el verano de 2004, ofrece cocina tradicional con toques de modernidad. El restaurante aprovecha los productos de la zona ( excelentes carnes, salazones, pulpo, productos de la huerta, pescados de la cercana ría de Vigo…) combinándolos con nuevos sabores y texturas.",
        nif = "78099079A",
        urlLogo =
            "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fthumbs.dreamstime.com%2Fb%2Flogo-semplice-della-tagliatella-piano-marchio-130436365.jpg&f=1&nofb=1",
        contactInfo = "+34 625485223";

  static Enterprise fromDTO(EnterpriseDTO dto) => Enterprise(
      dto.name, dto.description, dto.NIF, dto.profileImage, dto.contactInfo);
}
