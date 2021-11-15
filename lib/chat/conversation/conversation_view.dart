import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/root/pagecontrol_view.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';

class _Message {
  final bool isOther;
  final String username;

  _Message(this.isOther, this.username);

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
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Text(
        message,
        style: TextStyle(
            color:
                isOther ? theme.primary.textColor : theme.background.textColor),
      ),
    );
  }
}

@immutable
class FormalOfferMessage implements _Message {
  final bool isOther;
  final String username;
  final int version;

  FormalOfferMessage(this.isOther, this.username, this.version);

  @override
  Widget buildWidget() {
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Column(children: [
        Text(
          "Formal Offer version " + version.toString(),
          style: TextStyle(
              color: isOther
                  ? theme.primary.textColor
                  : theme.background.textColor),
        ),
        Row(
          children: [
            buildButton(theme, "Download PDF", Icons.download),
            const SizedBox(
              width: 20,
            ),
            buildButton(theme, "Sign PDF", Icons.vpn_key),
          ],
        ),
      ]),
    );
  }

  ElevatedButton buildButton(CommedTheme theme, String message, IconData icon) {
    return ElevatedButton.icon(
      label: Text(
        message,
        style: TextStyle(
            color:
                isOther ? theme.background.textColor : theme.primary.textColor),
      ),
      style: ElevatedButton.styleFrom(
        primary: isOther ? theme.background.color : theme.primary.color,
        onPrimary: theme.accent.color,
      ),
      onPressed: () {},
      icon: Icon(icon,
          color: isOther ? theme.primary.color : theme.background.color),
    );
  }
}

class ConversationScreen extends StatelessWidget {
  final List<_Message> messages;
  final String urlImage;
  final String enterprise;

  const ConversationScreen(
      {Key? key,
      required this.messages,
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
        builder: (ctx, theme) => Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                urlImage,
              ),
            ),
            const SizedBox(width: 10,),
            Text(
              enterprise,
              style: TextStyle(color: theme.primary.textColor),
            )
          ],
        ),
      ),
      actions: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Icon(Icons.search, color: theme.primary.textColor),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            )),
        Padding(
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
        ),
      ],
      elevation: 0,
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
                    )) as Widget) // ITS NOT UNNECESSARY!
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
    return StoreConnector<AppState, CommedTheme>(
      converter: (s) => s.state.theme,
      builder: (ctx, theme) => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: message.isOther
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Text(
              message.username,
              style: TextStyle(fontSize: 14),
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
              color: message.isOther
                  ? theme.primary.color
                  : theme.background.color,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: message.buildWidget(),
              ),
            ),
          ],
        ),
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
    return ConversationScreen(
      messages: List.filled(120, [
        const MessageModel(false, "user1", "Hi nice to meet y'all!"),
        const MessageModel(true, "user2", "Hi how are you doing!")
      ]).fold([], (xs, x) {
        xs.addAll(x);
        return xs;
      })
        ..add(FormalOfferMessage(true, "user2", 3))
        ..add(FormalOfferMessage(false, "user1", 4)),
      enterprise: "Moniatios",
      urlImage: "https://images.dog.ceo/breeds/pug/n02110958_14996.jpg",
    );
  }
}
