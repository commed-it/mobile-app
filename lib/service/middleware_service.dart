import 'dart:collection';

import 'package:flutter_app/chat/conversation/model.dart';
import 'package:flutter_app/chat/models.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/formaloffer/model/formaloffer.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/service/commed_api.dart';
import 'package:flutter_app/service/dto/enterprise_dto.dart';
import 'package:flutter_app/service/dto/formal_offer_dto.dart';
import 'package:flutter_app/service/dto/formal_offer_encounter_dto.dart';
import 'package:flutter_app/service/dto/list_chat_dto.dart';
import 'package:flutter_app/service/dto/search_dto.dart';
import 'package:flutter_app/widgets/carroussel.dart';

import 'dto/encounter_dto.dart';
import 'dto/message_dto.dart';
import 'dto/product_dto.dart';

class CommedMiddleware {
  final CommedAPI api = CommedAPI();

  String getMedia(String URN) {
    return api.URL() + URN;
  }

  Future<HashMap<int, Product>> getProducts() async {
    final List<ProductDTO> dtos = await api.getProducts();
    return await turnProductsToHashMap(dtos);
  }

  Future<HashMap<int, Product>> turnProductsToHashMap(
      List<ProductDTO> dtos) async {
    HashMap<int, Product> products = HashMap();
    for (ProductDTO e in dtos) {
      EnterpriseDTO enterpriseDTO = await api.getEnterpriseFromOwner(e.owner);
      products[e.id] = getProductFrom(e, enterpriseDTO);
    }
    return products;
  }

  Product getProductFrom(ProductDTO e, EnterpriseDTO enterpriseDTO) {
    return Product(e.id, getProductContentFrom(e, enterpriseDTO));
  }

  ProductContent getProductContentFrom(
      ProductDTO e, EnterpriseDTO enterpriseDTO) {
    return ProductContent(
        ImageContainer(e.images.map((img) => img.image).toList()),
        e.title,
        e.description,
        false,
        CompanySmallDetail(
            e.owner, getMedia(enterpriseDTO.profileImage), enterpriseDTO.name));
  }

  Future<Enterprise> getEnterprise(int userId) async {
    Enterprise ent =
        Enterprise.fromDTO(await api.getEnterpriseFromOwner(userId));
    return ent.copy(urlLogo: getMedia(ent.urlLogo));
  }

  Future<String?> login(String username, String password) async {
    String? token = await api.login(username, password);
    return token;
  }

  Future<Enterprise> getMyEnterprise() async {
    Enterprise ent = Enterprise.fromDTO(await api.getMyEnterprise());
    return ent.copy(urlLogo: getMedia(ent.urlLogo));
  }

  Future<List<FormalOffer>> getMyFormalOffers() async {
    int pk = await api.getMyId();
    List<FormalOfferDTO> formalOffersDTO = await api.getFormalOffer(pk);
    List<FormalOffer> res = List.empty(growable: true);
    for (FormalOfferDTO formalOffer in formalOffersDTO) {
      EncounterDTO encounterDTO =
          await api.getEncounters(formalOffer.encounterId);
      EnterpriseDTO enterpriseDTO =
          await api.getEnterpriseFromOwner(encounterDTO.client);
      Enterprise ent = Enterprise.fromDTO(enterpriseDTO);
      ent = ent.copy(urlLogo: getMedia(ent.urlLogo));
      ProductDTO productDTO = await api.getProduct(encounterDTO.product);
      FormalOffer offer =
          FormalOffer(ent, productDTO.title, formalOffer.version, true);
      res.add(offer);
    }
    return res;
  }

  Future<List<FormalOffer>> getMyFormalOffersEncounter() async {
    int pk = await api.getMyId();
    List<FormalOfferEncounterDTO> formalOffersDTO =
        await api.getFormalOfferEncounterDTO(pk);
    return formalOffersDTO
        .map<FormalOffer>((e) => FormalOffer(
            checkURL(Enterprise.fromDTO(e.theOtherClient)),
            e.product.title,
            e.formalOffer.version,
            false))
        .toList();
  }

  Future<List<ChatItemModel>> getListChat() async {
    int pk = await api.getMyId();
    List<ListChatDTO> listChats = await api.getListChatDTO(pk);
    return listChats
        .map<ChatItemModel>((chat) => ChatItemModel(
            chat.encounter.id,
            chat.theOtherClient.owner,
            getMedia(chat.theOtherClient.profileImage),
            chat.theOtherClient.name,
            chat.product.title))
        .toList();
  }

  Enterprise checkURL(Enterprise fromDTO) {
    return fromDTO.copy(urlLogo: getMedia(fromDTO.urlLogo));
  }

  Future<String?> register(LoginState loginViewState) async {
    String? token = await api.register(
        loginViewState.username,
        loginViewState.email,
        loginViewState.password,
        loginViewState.repeatPassword);
    return token;
  }

  Future<Enterprise> createEnterprise(LoginState loginViewState) async {
    return Enterprise.fromDTO(await api.createEnterprise(loginViewState.nif,
        loginViewState.company, loginViewState.contact, 'Description'));
  }

  Future<HashMap<int, Product>> searchProducts(SearchDTO searchDTO) async {
    List<ProductDTO> dtos = await api.searchProduct(searchDTO);
    dtos = dtos.map<ProductDTO>((dto) {
      List<ImageContainerDTO> images = dto.images
          .map<ImageContainerDTO>((e) => ImageContainerDTO(
              id: e.id, name: e.name, image: getMedia(e.image)))
          .toList();
      return ProductDTO(
          id: dto.id,
          owner: dto.owner,
          title: dto.title,
          images: images,
          description: dto.description,
          latitude: dto.latitude,
          longitude: dto.longitude,
          tag: dto.tag);
    }).toList();
    return turnProductsToHashMap(dtos);
  }

  Future<List<MessageModel>> getMessagesFromChat(String channelId) async {
    List<MessageDTO> dtos = await api.getMessagesFromChat(channelId);
    int id = await api.getMyId();
    return dtos
        .map<MessageModel>((e) => MessageModel(e.userId != id, e.msg))
        .toList();
  }
}
