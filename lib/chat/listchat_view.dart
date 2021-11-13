import 'package:flutter/material.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:flutter_app/widgets/search.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CommedTheme>(builder: (sto, theme) => Column(
      children: [
        Expanded(
          child: Container(
            color: theme.background.color,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Searcher(),
                  Padding(padding: EdgeInsets.only(top: 5),),
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
    ),
    converter: (sto) => sto.state.theme);
  }
}
