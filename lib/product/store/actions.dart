import 'package:flutter/material.dart';
import 'package:flutter_app/store/actions.dart';

@immutable
class ToggleDescription extends AppAction {
  final int productId;

  ToggleDescription(this.productId);
}