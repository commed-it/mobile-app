import 'package:flutter/material.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

@immutable
class MovePageFromPageController extends AppAction {
  final int numPage;

  const MovePageFromPageController(this.numPage);
}

@immutable
class ProfileButtonAction extends AppAction {
  const ProfileButtonAction();
}