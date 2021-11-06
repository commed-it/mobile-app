import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';

class FormalOffersView extends StatelessWidget {
  const FormalOffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        child: const Center(child: Text("Formal Offers")));
  }
}