import 'package:flutter/material.dart';


BoxDecoration fieldBoxDecoration() {
  return const BoxDecoration(boxShadow: [
    BoxShadow(color: Colors.grey, blurRadius: 1, offset: Offset(1, 1)),
  ], color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20)));
}
