import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
