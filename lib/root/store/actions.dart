
import 'package:flutter/material.dart';

@immutable
abstract class PageControlAction {
  const PageControlAction();
}

@immutable
class MovePageFromPageController extends PageControlAction {
  final int numPage;

  const MovePageFromPageController(this.numPage);
}
