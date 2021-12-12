import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/chat/message/conversation.dart';
import 'package:flutter_app/chat/message/sender.dart';
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
            context, theme, enterprise, urlImage, conversationId, enterpriseId),
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
            //crossAxisAlignment: CrossAxisAlignment.start,
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
    return StoreConnector<AppState, ChatModel>(
      converter: (sto) => sto.state.chatModel,
      builder: (cto, chatModel) => ConversationScreen(
        conversationId: chatModel.idEncounter,
        messages: List.filled(20, [
          const MessageModel(false, "Hi nice to meet y'all!"),
          const MessageModel(true, "Hi how are you doing!")
        ]).fold([], (xs, x) {
          xs.addAll(x);
          return xs;
        })
          ..add(FormalOfferMessage(true, 3))
          ..add(FormalOfferMessage(false, 4)),
        enterpriseId: chatModel.idEnterprise,
        enterprise: chatModel.nameCompany,
        urlImage:
            chatModel.urlProfile,
        theme: theme,
      ),
    );
  }
}
