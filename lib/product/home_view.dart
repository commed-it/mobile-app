import 'package:flutter/material.dart';
import 'package:flutter_app/generic/carrousel/exported.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/widgets/generic_summary.dart';
import 'package:redux/redux.dart';

import '../constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: backgroundColor, child: buildCenteredHome());
  }

  Center buildCenteredHome() => Center(child: buildHome());

  Column buildHome() {
    return Column(
      children: [
        GenericCarrousel(
          getContainer: (Store<AppState> s) {
            return s.state.imageContainerMock;
          },
        ),
        GenSummaryButton.only(
          ratio: 0.8,
          image: const NetworkImage(
              "https://images.dog.ceo/breeds/boxer/n02108089_15702.jpg"),
          title: "Moniatios",
          subtitle: "Subtitle",
          onPressed: () {},
        ),
        Row(
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "DescriptionDescriptionDescriptionDescrip32tionDescriptionDescriptionionDe323232scri ption Descr iptio nDescriptionDescriptionDescription",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
