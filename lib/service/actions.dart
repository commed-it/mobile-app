import 'dart:collection';
import 'dart:convert';

import 'package:flutter_app/auth/actions.dart';
import 'package:flutter_app/chat/conversation/model.dart';
import 'package:flutter_app/chat/models.dart';
import 'package:flutter_app/chat/store/actions.dart';
import 'package:flutter_app/enterprise/model/enterprise.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/formaloffer/model/formaloffer.dart';
import 'package:flutter_app/formaloffer/store/actions.dart';
import 'package:flutter_app/login/store/store.dart';
import 'package:flutter_app/product/model/product.dart';
import 'package:flutter_app/searcher/action.dart';
import 'package:flutter_app/service/dto/message_dto.dart';
import 'package:flutter_app/service/dto/product_dto.dart';
import 'package:flutter_app/service/dto/search_dto.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'dto/formal_offer_dto.dart';

ThunkAction<AppState> reloadProducts() {
  return (Store<AppState> store) async {
    final HashMap<int, Product> products =
        await store.state.commedMiddleware.getProducts();
    store.dispatch(SetProductList(products));
  };
}

ThunkAction<AppState> loadEnterprise(int userId) {
  return (Store<AppState> store) async {
    final Enterprise enterprise =
        await store.state.commedMiddleware.getEnterprise(userId);
    store.dispatch(NavigateToEnterpriseDetail(enterprise));
  };
}

ThunkAction<AppState> loginThunkAction(String username, String password) {
  return (Store<AppState> store) async {
    String? tok = await store.state.commedMiddleware.login(username, password);
    if (tok == null) {
      store.dispatch(CouldntLogAction());
      return;
    }
    store.dispatch(LoginAction(tok != null));
    final Enterprise enterprise =
        await store.state.commedMiddleware.getMyEnterprise();
    int pk = await store.state.commedMiddleware.getMyId();
    store.dispatch(SetUserId(pk));
    store.dispatch(setMyEnterpriseDetail(enterprise));
    store.dispatch(ClearSearch());
  };
}

ThunkAction<AppState> registerThunkAction(LoginState loginViewState) {
  return (Store<AppState> store) async {
    String? tok = await store.state.commedMiddleware.register(loginViewState);
    if (tok == null) {
      store.dispatch(CouldntLogAction());
      return;
    }
    final Enterprise enterprise =
        await store.state.commedMiddleware.createEnterprise(loginViewState);
    int pk = await store.state.commedMiddleware.getMyId();
    store.dispatch(SetUserId(pk));
    store.dispatch(LoginAction(tok != null));
    store.dispatch(setMyEnterpriseDetail(enterprise));
    store.dispatch(ClearSearch());
  };
}

ThunkAction<AppState> logoutThunk() {
  return (Store<AppState> store) async {
    store.dispatch(LogoutAction());
  };
}

ThunkAction<AppState> loadMyFormalOffers() {
  return (Store<AppState> store) async {
    List<FormalOffer> formalOffers =
        await store.state.commedMiddleware.getMyFormalOffersEncounter();
    store.dispatch(SetFormalOffers(formalOffers));
  };
}

ThunkAction<AppState> loadListChat() {
  return (Store<AppState> store) async {
    List<ChatItemModel> chatModels =
        await store.state.commedMiddleware.getListChat();
    store.dispatch(SetListChat(chatModels));
  };
}

ThunkAction<AppState> submitSearch(String text) {
  return (Store<AppState> store) async {
    if (text == "") {
      store.dispatch(NavigateBack());
      return;
    }
    SearchDTO searchDTO = SearchDTO(
        locationDTO: LocationDTO(latitude: 0.0, longitude: 0.0, distance: 5.0),
        tag: List.generate(1, (index) => TagDTO(name: text)));
    final HashMap<int, Product> products =
        await store.state.commedMiddleware.searchProducts(searchDTO);
    store.dispatch(SetSearch(text));
    store.dispatch(SetProductList(products));
    store.dispatch(NavigateBack());
  };
}

ThunkAction<AppState> clearSearchAndReload() {
  return (Store<AppState> store) async {
    store.dispatch(ClearSearch());
    final HashMap<int, Product> products =
        await store.state.commedMiddleware.getProducts();
    store.dispatch(SetProductList(products));
  };
}

ThunkAction<AppState> loadThunkConversationModel(ChatModel chatModel) {
  return (Store<AppState> store) async {
    List<CommedMessage> chatModels = await store.state.commedMiddleware
        .getMessagesFromChat(chatModel.idEncounter);
    store.dispatch(SetListMessages(chatModels));
    store.dispatch(NavigateToChat(chatModel));
  };
}

ThunkAction<AppState> connectThunkWebSocketChannel(String idEncounter) {
  return (Store<AppState> store) async {
    WebSocketChannel channel;
    int userId = store.state.userId;
    if (!store.state.chatState.webSockets.containsKey(idEncounter)) {
      channel =
          WebSocketChannel.connect(Uri.parse(store.state.getWebSocketURI()!));
      store.state.chatState.webSockets[idEncounter] = channel;
      channel.stream.listen((event) async {
        print("has listened: " + event);
        var json = jsonDecode(event);
        CommedMessage message;
        if (json['type'] == 'message') {
          var dto = MessageContentDTO.fromJson(json);
          message = MessageModal(userId != dto.user, dto);
        } else {
          var dto = MessageFormalOfferDTO.fromJson(json);
          FormalOfferDTO fOfferDTO = await store.state.commedMiddleware.api
              .getFormalOffer(dto.formalOffer);
          message = FormalOfferMessage(userId != dto.user, fOfferDTO.version);
        }
        store.dispatch(AddListMessages(message));
      }, onError: (error) => print(error));
    } else {
      channel = store.state.chatState.webSockets[idEncounter]!;
    }
    store.dispatch(SetEncounterChannel(idEncounter, channel));
  };
}

ThunkAction<AppState> sendThunkMessageThroughChat(String message) {
  return (Store<AppState> store) async {
    if (message == '')
      return;
    var content = <String, dynamic>{
      'user': store.state.userId,
      'type': 'message',
      'message': message,
    };
    store.state.chatState.currentChatWebSocket!.sink.add(jsonEncode(content));
    store.dispatch(const SetSenderMessage(''));
  };
}

class SetProductList extends AppAction {
  final HashMap<int, Product> products;

  const SetProductList(this.products);
}
