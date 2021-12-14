import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/chat/conversation/model.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'actions.dart';

class ChatState {
  final HashMap<String, WebSocketChannel> webSockets;
  final WebSocketChannel? currentChatWebSocket;
  final List<CommedMessage> messages;
  final String writingMessage;
  final TextEditingController controller;

  const ChatState(this.webSockets, this.currentChatWebSocket, this.messages,
      this.writingMessage, this.controller);

  ChatState.init()
      : webSockets = HashMap.identity(),
        currentChatWebSocket = null,
        messages = List.empty(),
        writingMessage = '',
        controller = TextEditingController();

  ChatState copy(
          {HashMap<String, WebSocketChannel>? webSockets,
          WebSocketChannel? currentWebSocket,
          List<CommedMessage>? messages,
          String? writingMessage,
          TextEditingController? controller}) =>
      ChatState(
        webSockets ?? this.webSockets,
        currentWebSocket ?? this.currentChatWebSocket,
        messages ?? this.messages,
        writingMessage ?? this.writingMessage,
        controller ?? this.controller,
      );
}

AppState ListChatReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case SetListChat:
      action = action as SetListChat;
      return prev.copy(listChats: action.chatModel);
    case NavigateToChat:
      action = action as NavigateToChat;
      return prev.copy(
          navigatorKey: prev.navigatorKey..currentState!.pushNamed(Routes.chat),
          chatModel: action.chatModel);
    case SetListMessages:
      action = action as SetListMessages;
      ChatState chatState = prev.chatState.copy(messages: action.msgs);
      return prev.copy(chatState: chatState);
    case SetEncounterChannel:
      action = action as SetEncounterChannel;
      var websockets = prev.chatState.webSockets;
      websockets[action.idEncounter] = action.webSocketChannel;
      return prev.copy(
          chatState: prev.chatState.copy(
              currentWebSocket: action.webSocketChannel,
              webSockets: websockets));
    case SetSenderMessage:
      action = action as SetSenderMessage;
      return prev.copy(
          chatState: prev.chatState.copy(
              controller: prev.chatState.controller..clear()));
    default:
      return prev;
  }
}
