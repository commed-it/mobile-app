import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/chat/conversation/model.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MessageWidget extends StatelessWidget {
  final CommedMessage message;

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
