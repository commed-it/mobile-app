import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/chat/message/conversation.dart';
import 'package:flutter_app/chat/message/sender.dart';
import 'package:flutter_app/enterprise/store/actions.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'model.dart';

class ConversationScreen extends StatelessWidget {
  final List<CommedMessage> messages;
  final int conversationId;
  final String urlImage;
  final String enterprise;

  const ConversationScreen(
      {Key? key,
      required this.messages,
      required this.conversationId,
      required this.urlImage,
      required this.enterprise})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Scaffold(
        appBar: buildAppBar(context, theme),
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
              const MessageSender(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, CommedTheme theme) {
    return AppBar(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: theme.appBarColor),
      backgroundColor: theme.appBarColor,
      title: StoreConnector<AppState, CommedTheme>(
        converter: (s) => s.state.theme,
        builder: (ctx, theme) => buildLogoAndEnterprise(theme),
      ),
      actions: [
        buildSearchButton(theme, context),
        buildAccount(theme),
      ],
      elevation: 0,
    );
  }

  Row buildLogoAndEnterprise(CommedTheme theme) {
    return Row(
      children: [
        StoreConnector<AppState, VoidCallback>(
          converter: (sto) =>
              () => sto.dispatch(NavigateToEnterpriseDetail(conversationId)),
          builder: (con, callback) => InkWell(
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                urlImage,
              ),
            ),
            onTap: callback,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          enterprise,
          style: TextStyle(color: theme.primary.textColor),
        )
      ],
    );
  }

  Widget buildSearchButton(CommedTheme theme, BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
        converter: (sto) =>
            () => sto.dispatch(const NavigateToNext(Routes.searcher)),
        builder: (cto, callback) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Icon(Icons.search, color: theme.primary.textColor),
              onPressed: callback,
            )));
  }

  Padding buildAccount(CommedTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: StoreConnector<AppState, VoidCallback>(
          builder: (context, callback) {
            return IconButton(
              icon: Icon(
                Icons.account_circle,
                color: theme.primary.textColor,
              ),
              onPressed: callback,
            );
          },
          converter: (store) =>
              () => store.dispatch(const NavigateToNext(Routes.login))),
    );
  }
}

class MockConversation extends StatelessWidget {
  const MockConversation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConversationScreen(
      conversationId: 1,
      messages: List.filled(120, [
        const MessageModel(false, "Hi nice to meet y'all!"),
        const MessageModel(true, "Hi how are you doing!")
      ]).fold([], (xs, x) {
        xs.addAll(x);
        return xs;
      })
        ..add(FormalOfferMessage(true, 3))
        ..add(FormalOfferMessage(false, 4)),
      enterprise: "La Bicicleta",
      urlImage:
          "https://instagram.fbcn5-1.fna.fbcdn.net/v/t51.2885-19/s150x150/25024378_169126683844186_21293180838215680_n.jpg?_nc_ht=instagram.fbcn5-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=jVg3B7QJJo0AX9zxkms&edm=ABfd0MgBAAAA&ccb=7-4&oh=4731660aa270050f2805bb12fd3a2a97&oe=6196859C&_nc_sid=7bff83",
    );
  }
}
