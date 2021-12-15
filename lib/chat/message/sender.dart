import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/chat/store/actions.dart';
import 'package:flutter_app/service/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/src/store.dart';

typedef String Converter(Store<AppState> store);

class MessageSender extends StatelessWidget {
  final CommedTheme theme;

  MessageSender({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TextEditingController>(
      converter: (sto) => sto.state.chatState.controller,
      builder: (cto, controller) => StoreConnector<AppState, dynamic Function(dynamic)>(
        converter: (sto) => (str) => sto.dispatch(SetSenderMessage(str)),
        builder: (cto, onChangedMessage) => StoreConnector<AppState, VoidCallback>(
          converter: (sto) => () => sto.dispatch(sendThunkMessageThroughChat(controller.text)),
          builder: (cto, sendMessage) => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: TextField(
                    controller: controller,
                    cursorColor: Colors.black,
                    cursorHeight: 25,
                    decoration: InputDecoration(
                        border: buildOutlineInputBorder(theme),
                        focusedBorder: buildOutlineInputBorder(theme),
                        disabledBorder: buildOutlineInputBorder(theme),
                        enabledBorder: buildOutlineInputBorder(theme),
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
                      iconSize: 25,
                      onPressed: sendMessage,
                    ),
                    backgroundColor: theme.primary.color,
                    radius: 25,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(CommedTheme theme) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.teal.shade800, width: 2),
    );
  }
}
