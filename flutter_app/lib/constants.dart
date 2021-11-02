import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/views/register_view.dart';

const Color backgroundColor = Color.fromARGB(255, 240, 240, 240);
const MaterialColor appBarColor = Colors.green;

appBarFactory(context) {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: appBarColor),
    backgroundColor: appBarColor,
    title: const Text('Commed'),
    actions: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterView()),
            );
          },
        ),
      ),
    ],
    elevation: 0,
  );
}
