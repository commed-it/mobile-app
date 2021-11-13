import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/root/pagecontrol_view.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';

class _Message {
  final bool isOther;
  final String username;

  _Message(this.isOther, this.username);

  Color get color => Colors.teal;

  Widget buildWidget() {
    return const Text("You shouldn't see this");
  }
}

@immutable
class MessageModel implements _Message {
  final bool isOther;
  final String username;
  final String message;

  const MessageModel(this.isOther, this.username, this.message);

  @override
  Widget buildWidget() {
    return Text(message);
  }

  @override
  // TODO: implement color
  Color get color => Colors.teal; // TODO Change

}

@immutable
class FormalOfferMessage implements _Message {
  @override
  // TODO: implement isMine
  bool get isOther => throw UnimplementedError();

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

class ConversationScreen extends StatelessWidget {
  final List<_Message> messages;

  const ConversationScreen({Key? key, required this.messages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Conversation(messages: messages),
          ],
        ),
        MessageSender(),
      ],
    );
  }
}

class MessageSender extends StatelessWidget {
  const MessageSender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: TextField(
              onChanged: (str) {},
              cursorColor: Colors.black,
              cursorHeight: 25,
              decoration: InputDecoration(
                  border: buildOutlineInputBorder(),
                  focusedBorder: buildOutlineInputBorder(),
                  disabledBorder: buildOutlineInputBorder(),
                  enabledBorder: buildOutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'say something...',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  )),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 20, 10),
            child: CircleAvatar(
              child: IconButton(
                icon: const Icon(Icons.send_rounded),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {},
              ),
              backgroundColor: Colors.black,
              radius: 25,
            ))
      ],
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.black, width: 2),
    );
  }
}

class Conversation extends StatelessWidget {
  const Conversation({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<_Message> messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: messages
                .map((x) => (Row(
                      mainAxisAlignment: x.isOther
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [MessageWidget(message: x)],
                    )) as Widget)// ITS NOT UNNECESSARY!
                .toList()
            ..add(const Padding(padding: EdgeInsets.all(35))),
          )),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final _Message message;

  const MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            message.isOther ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            message.username,
            style: const TextStyle(fontSize: 14),
          ),
          Material(
            elevation: 10,
            borderRadius: message.isOther
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
            color: message.color,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: message.buildWidget(),
            ),
          ),
        ],
      ),
    );
  }
}


class MockConversation extends StatelessWidget {
  const MockConversation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(
      converter: (sto) => sto.state.theme,
      builder: (ctx, theme) => Scaffold(
        appBar: buildAppBar(context, theme),
        body: ConversationScreen(
          messages: List.filled(120, [
            const MessageModel(false, "user1", "Hi nice to meet y'all!"),
            const MessageModel(true, "user2", "Hi how are you doing!")
          ]).fold([], (xs, x) {
            xs.addAll(x);
            return xs;
          }),
        ),
      ),
    );
  }
}
