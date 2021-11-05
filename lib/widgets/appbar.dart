import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/views/login_view.dart';
import '../constants.dart';

appBarFactory(context) {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: appBarColor),
    backgroundColor: appBarColor,
    title: Image.asset(
      'assets/logo-white.png',
      fit: BoxFit.cover,
      height: 50,
    ),
    actions: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: IconButton(
          icon: const Icon(
            Icons.account_circle,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
          },
        ),
      ),
    ],
    elevation: 0,
  );
}
