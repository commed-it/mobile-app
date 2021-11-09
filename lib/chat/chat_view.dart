import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/generic_summary.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GenSummaryButton.only(
                    ratio: 0.8,
                    image: const NetworkImage(
                        "https://images.dog.ceo/breeds/boxer/n02108089_15702.jpg"),
                    title: "Moniatios",
                    subtitle: "Subtitle",
                    onPressed: () {},
                  ),
                  const ListDivider(),
                  GenSummaryButton.only(
                    ratio: 0.8,
                    image: NetworkImage(
                        "https://images.dog.ceo/breeds/pug/n02110958_14996.jpg"),
                    title: "Chicken",
                    subtitle: "Subtitle",
                    onPressed: () {},
                  ),
                  const ListDivider(),
                  GenSummaryButton.only(
                      ratio: 0.8,
                      image: NetworkImage(
                          "https://images.dog.ceo/breeds/pug/n02110958_14996.jpg"),
                      title: "Chicken",
                      subtitle: "Subtitle",
                      onPressed: () {}),
                  ListDivider(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
