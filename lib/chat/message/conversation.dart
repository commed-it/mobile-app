import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/chat/conversation/model.dart';
import 'package:flutter_app/chat/message/message.dart';

class Conversation extends StatelessWidget {
  const Conversation({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<CommedMessage> messages;

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

