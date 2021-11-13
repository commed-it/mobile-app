import 'package:flutter/material.dart';

class _Conversation {
  final bool isMine;
  final String username;

  _Conversation(this.isMine, this.username);

  Color get color => Colors.teal;

  Widget buildWidget() {
    return const Text("You shouldn't see this");
  }
}

@immutable
class ConversationMsmModel implements _Conversation {
  @override
  // TODO: implement isMine
  bool get isMine => throw UnimplementedError();

  @override
  Widget buildWidget() {
    // TODO: implement buildWidget
    throw UnimplementedError();
  }

  @override
  // TODO: implement username
  String get username => throw UnimplementedError();

  @override
  // TODO: implement color
  Color get color => throw UnimplementedError();
}

@immutable
class ConversationFormalOfferModel implements _Conversation {
  @override
  // TODO: implement isMine
  bool get isMine => throw UnimplementedError();

  @override
  Widget buildWidget() {
    // TODO: implement buildWidget
    throw UnimplementedError();
  }

  @override
  // TODO: implement username
  String get username => throw UnimplementedError();

  @override
  // TODO: implement color
  Color get color => throw UnimplementedError();
}

class ConversationWidget extends StatelessWidget {
  final _Conversation conversation;

  const ConversationWidget({Key? key, required this.conversation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: conversation.isMine
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Text(
            conversation.username,
            style: const TextStyle(fontSize: 14),
          ),
          Material(
            elevation: 10,
            borderRadius: conversation.isMine
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
            color: conversation.color,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: conversation.buildWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
