import 'dart:convert';

import 'package:flutter_app/service/dto/enterprise_dto.dart';
import 'package:flutter_app/service/dto/product_dto.dart';
import 'package:http/http.dart';

class CommedAPI {
  final String postsURL = "http://10.0.2.2:8000";

  Future<List<ProductDTO>> getPosts() async {
    Uri uri = Uri.parse(postsURL + "/product");
    Response res = await get(uri);
    if (res.statusCode == 200) {
      List<ProductDTO> posts = jsonDecode(res.body)
          .map<ProductDTO>(
            (dynamic item) => ProductDTO.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<EnterpriseDTO> getEnterpriseFromOwner(int owner) async {
    Uri uri = Uri.parse(postsURL + "/enterprise/user/" + owner.toString());
    Response res = await get(uri);
    if (res.statusCode == 200) {
      EnterpriseDTO enterpriseDTO =
          EnterpriseDTO.fromJson(jsonDecode(res.body));
      return enterpriseDTO;
    }
    throw "Unable to retrieve enterprise from owner: " + owner.toString();
  }
}
