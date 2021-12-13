import 'package:flutter_app/chat/conversation/model.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'actions.dart';

class ChatState {
  final List<WebSocketChannel> webSockets;
  final WebSocketChannel? currentChatWebSocket;
  final List<CommedMessage> messages;

  const ChatState(this.webSockets, this.currentChatWebSocket, this.messages);

  ChatState.init()
      : webSockets = List.empty(),
        currentChatWebSocket = null,
        messages = List.filled(20, [
          const MessageModal(false, "Hi nice to meet y'all!"),
          const MessageModal(true, "Hi how are you doing!")
        ]).fold([], (xs, x) {
          xs.addAll(x);
          return xs;
        })
          ..add(FormalOfferMessage(true, 3))
          ..add(FormalOfferMessage(false, 4));

  ChatState copy(
          {List<WebSocketChannel>? webSockets,
          WebSocketChannel? currentWebSocket,
          List<CommedMessage>? messages}) =>
      ChatState(
        webSockets ?? this.webSockets,
        currentWebSocket ?? this.currentChatWebSocket,
        messages ?? this.messages,
      );
}

AppState ListChatReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case SetListChat:
      action = action as SetListChat;
      return prev.copy(listChats: action.chatModel);
    case NavigateToChat:
      action = action as NavigateToChat;
      print(action.chatModel.idEncounter);
      return prev.copy(
          navigatorKey: prev.navigatorKey..currentState!.pushNamed(Routes.chat),
          chatModel: action.chatModel);
    case SetListMessages:
      action = action as SetListMessages;
      ChatState chatState = prev.chatState.copy(messages: action.msgs);
      return prev.copy(chatState: chatState);
    default:
      return prev;
  }
}
