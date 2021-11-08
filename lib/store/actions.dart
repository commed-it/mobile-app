import 'package:flutter/material.dart';

class Routes {
  static const String home = "HOME";
  static const String login = "LOGIN";

}

@immutable
abstract class AppAction {
  const AppAction();
}

class NavigateToNext {
  final String destinationRoute;
  NavigateToNext(this.destinationRoute);
}
class NavigateToNextAndReplace {
  final String destinationRoute;
  NavigateToNextAndReplace(this.destinationRoute);
}
class NavigateBack {}
