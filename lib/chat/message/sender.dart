import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/store/theme.dart';

class MessageSender extends StatelessWidget {
  final CommedTheme theme;

  const MessageSender({Key? key, required this.theme}) : super(key: key);

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
                onPressed: () {},
              ),
              backgroundColor: theme.primary.color,
              radius: 25,
            ))
      ],
    );
  }

  OutlineInputBorder buildOutlineInputBorder(CommedTheme theme) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.teal.shade800, width: 2),
    );
  }
}
