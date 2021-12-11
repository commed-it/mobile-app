import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/service/commed_api.dart';
import 'package:flutter_app/service/dto/enterprise_dto.dart';
import 'package:flutter_app/widgets/carroussel.dart';

import 'dto/product_dto.dart';

class CommedMiddleware {
  final CommedAPI api = CommedAPI();

  Future<List<Product>> getProducts() async {
    final List<ProductDTO> dtos = await api.getPosts();
    List<Product> products = List.empty(growable: true);
    for (ProductDTO e in dtos) {
      EnterpriseDTO enterpriseDTO = await api.getEnterpriseFromOwner(e.id);
      products.add(Product(
          e.id,
          ProductContent(
              ImageContainer(e.images),
              e.title,
              e.description,
              false,
              CompanySmallDetail(
                  enterpriseDTO.profileImage, enterpriseDTO.name))));
    }
    return products;
  }
}
