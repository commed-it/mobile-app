import 'dart:convert';

import 'package:flutter_app/service/dto/enterprise_dto.dart';
import 'package:flutter_app/service/dto/formal_offer_dto.dart';
import 'package:flutter_app/service/dto/formal_offer_encounter_dto.dart';
import 'package:flutter_app/service/dto/product_dto.dart';
import 'package:http/http.dart';

import 'dto/encounter_dto.dart';
import 'dto/list_chat_dto.dart';

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

  Future<List<ProductDTO>> searchProduct() async {
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

  Future<ProductDTO> getProduct(int productId) async {
    Uri uri = Uri.parse(postsURL + "/product/" + productId.toString());
    Response res = await get(uri);
    if (res.statusCode == 200) {
      return ProductDTO.fromJson(jsonDecode(res.body));
    }
    throw "Unable to retrieve product " + productId.toString();
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

  Future<String?> login(String username, String password) async {
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
      return token!;
    }
    throw "Unable to login with " + username + " and " + password;
  }

  Future<int> getMyId() async {
    Uri uri = Uri.parse(postsURL + "/auth/user/");
    Response res = await get(uri, headers: <String, String>{
      'Authorization': "Token " + token!,
    });
    if (res.statusCode == 200) {
      return jsonDecode(res.body)['pk'];
    }
    throw "Unable to get themself";
  }

  Future<EnterpriseDTO> getMyEnterprise() async {
    var pk = await getMyId();
    return getEnterpriseFromOwner(pk);
  }

  Future<List<FormalOfferDTO>> getFormalOffer(int userId) async {
    Uri uri =
        Uri.parse(postsURL + "/offer/formaloffer/user/" + userId.toString());
    Response res = await get(uri);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List)
          .map<FormalOfferDTO>((e) => FormalOfferDTO.fromJson(e))
          .toList();
    }
    throw "unable to get the list of offers";
  }

  Future<List<FormalOfferEncounterDTO>> getFormalOfferEncounterDTO(
      int userId) async {
    Uri uri = Uri.parse(
        postsURL + "/offer/formaloffer/fromUser/" + userId.toString());
    Response res = await get(uri);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List)
          .map<FormalOfferEncounterDTO>(
              (e) => FormalOfferEncounterDTO.fromJson(e))
          .toList();
    }
    throw "unable to get the list of encounters and formal offers";
  }

  Future<List<ListChatDTO>> getListChatDTO(
      int userId) async {
    Uri uri = Uri.parse(
        postsURL + "/offer/encounter/fromUser/" + userId.toString());
    Response res = await get(uri);
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List)
          .map<ListChatDTO>(
              (e) => ListChatDTO.fromJson(e))
          .toList();
    }
    throw "unable to get the list of encounters and formal offers";
  }

  Future<EncounterDTO> getEncounters(String encounterId) async {
    Uri uri = Uri.parse(postsURL + "/offer/encounter/" + encounterId);
    Response res = await get(uri);
    if (res.statusCode == 200) {
      return EncounterDTO.fromJson(jsonDecode(res.body));
    }
    throw "unable to get the encounter listoffer by id encounter " +
        encounterId;
  }

  Future<String?> register(String username, String email, String password,
      String repeatPassword) async {
    Uri uri = Uri.parse(postsURL + "/auth/registration/");
    Response res = await post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password1': password,
          'password2': repeatPassword,
        }));
    if (res.statusCode == 201) {
      token = jsonDecode(res.body)['key'];
      setCookie = res.headers['set-cookie']!;
      return token!;
    }
    throw "unable to register";
  }

  Future<EnterpriseDTO> createEnterprise(
      String nif, String company, String contact, String s) async {
    int pk = await getMyId();
    Uri uri = Uri.parse(postsURL + "/enterprise/");
    Response res = await post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'owner': pk,
          'NIF': nif,
          'name': company,
          'contactInfo': contact,
          'description': s,
        }));
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 201) {
      return EnterpriseDTO.fromJson(jsonDecode(res.body));
    }
    throw "unable to create enterprise";
  }
}
