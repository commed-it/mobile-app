import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/chat/message/conversation.dart';
import 'package:flutter_app/chat/message/sender.dart';
import 'package:flutter_app/chat/store/store.dart';
import 'package:flutter_app/service/actions.dart';
import 'package:flutter_app/service/dto/message_dto.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/appbar.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models.dart';
import 'model.dart';

class ConversationScreen extends StatelessWidget {
  final List<CommedMessage> messages;
  final String conversationId;
  final String urlImage;
  final String enterprise;
  final int enterpriseId;
  final CommedTheme theme;

  const ConversationScreen(
      {Key? key,
      required this.messages,
      required this.conversationId,
      required this.urlImage,
      required this.enterpriseId,
      required this.enterprise,
      required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Scaffold(
        appBar: buildChatAppBar(
          context,
          theme,
          enterprise,
          urlImage,
          conversationId,
          enterpriseId,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.background.color,
                  theme.lightBackground,
                ]),
          ),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Column(
                children: [
                  Conversation(messages: messages),
                ],
              ),
              MessageSender(theme: theme),
            ],
          ),
        ),
      ),
    );
  }
}

class MockConversation extends StatelessWidget {
  final CommedTheme theme;

  const MockConversation({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      converter: (sto) => sto.state.userId,
      builder: (cto, userId) => StoreConnector<AppState, ChatModel>(
        converter: (sto) => sto.state.chatModel,
        builder: (cto, chatModel) => StoreConnector<AppState, ChatState>(
          onInit: (sto) =>
              sto.dispatch(connectThunkWebSocketChannel(chatModel.idEncounter)),
          converter: (sto) => sto.state.chatState,
          builder: (cto, chatState) =>
               buildConversationScreen(chatModel, chatState, userId),
        ),
      ),
    );
  }

  ConversationScreen buildConversationScreen(
      ChatModel chatModel, ChatState chatState, userId) {
    return ConversationScreen(
      conversationId: chatModel.idEncounter,
      messages: getMessages(chatState, userId),
      enterpriseId: chatModel.idEnterprise,
      enterprise: chatModel.nameCompany,
      urlImage: chatModel.urlProfile,
      theme: theme,
    );
  }

  List<CommedMessage> getMessages(ChatState chatState, userId) {
    return chatState.messages;
  }
}
