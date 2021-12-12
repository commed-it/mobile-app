import 'dart:collection';

import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/service/commed_api.dart';
import 'package:flutter_app/service/dto/enterprise_dto.dart';
import 'package:flutter_app/widgets/carroussel.dart';

import 'dto/product_dto.dart';

class CommedMiddleware {
  final CommedAPI api = CommedAPI();

  String getMedia(String URN) {
    return api.URL() + URN;
  }

  Future<HashMap<int, Product>> getProducts() async {
    final List<ProductDTO> dtos = await api.getProducts();
    HashMap<int, Product> products = HashMap();
    for (ProductDTO e in dtos) {
      EnterpriseDTO enterpriseDTO = await api.getEnterpriseFromOwner(e.owner);
      products[e.id] = Product(
          e.id,
          ProductContent(
              ImageContainer(e.images.map((img) => img.image).toList()),
              e.title,
              e.description,
              false,
              CompanySmallDetail(e.owner, getMedia(enterpriseDTO.profileImage),
                  enterpriseDTO.name)));
    }
    return products;
  }

  Future<Enterprise> getEnterprise(int userId) async {
    Enterprise ent = Enterprise.fromDTO(await api.getEnterpriseFromOwner(userId));
    return ent.copy(urlLogo: getMedia(ent.urlLogo));
  }

  Future<String> login(String username, String password) async {
    return await api.login(username, password);
  }

  Future<Enterprise> getMyEnterprise() async {
    Enterprise ent = Enterprise.fromDTO(await api.getMyEnterprise());
    return ent.copy(urlLogo: getMedia(ent.urlLogo));
  }
}
