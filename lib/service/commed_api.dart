import 'dart:convert';

import 'package:flutter_app/service/dto/enterprise_dto.dart';
import 'package:flutter_app/service/dto/product_dto.dart';
import 'package:http/http.dart';

class CommedAPI {
  final String postsURL = "http://10.0.2.2:8000";
  String? token = null;
  String? setCookie = null;

  String URL() {
    return postsURL;
  }

  Future<List<ProductDTO>> getProducts() async {
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

  Future<String> login(String username, String password) async {
    Uri uri = Uri.parse(postsURL + "/auth/login/");
    Response res = await post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }));
    if (res.statusCode == 200) {
      token = jsonDecode(res.body)['key'];
      setCookie = res.headers['set-cookie']!;
      print(getMyEnterprise().toString());
      return token!;
    }
    throw "Unable to login with " + username + " and " + password;
  }

  Future<EnterpriseDTO> getMyEnterprise() async {
    Uri uri = Uri.parse(postsURL + "/auth/user/");
    Response res = await get(uri, headers: <String, String>{
      'Authorization': "Token " + token!,
    });
    if (res.statusCode == 200) {
      int pk = jsonDecode(res.body)['pk'];
      return getEnterpriseFromOwner(pk);
    }
    throw "unable to get the enterprise";
  }
}
