import 'package:flutter/material.dart';
import 'package:flutter_app/login/login_view.dart';
import 'package:flutter_app/login/widgets/login.dart';
import 'package:flutter_app/store/router.dart';


class LoginRouter extends RouterA {
  @override
  Widget getWidget() {
    return LoginView();
  }
}
