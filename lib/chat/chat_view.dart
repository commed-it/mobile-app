import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';

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
                  GenericSummary.only(
                    ratio: 0.9,
                    image: NetworkImage(
                        "https://images.dog.ceo/breeds/boxer/n02108089_15702.jpg"),
                    title: "Moniatos",
                    subtitle: "Que en són de bons",
                  ),
                  Divider(),
                  GenericSummary.only(
                    ratio: 0.9,
                    image: NetworkImage(
                        "https://images.dog.ceo/breeds/pug/n02110958_14996.jpg"),
                    title: "Oli Macià",
                    subtitle: "No es vi.",
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GenericSummary extends StatelessWidget {
  final Widget rightWidget;
  final double textRatio;
  final double imgRatio;
  final ImageProvider image;
  final String title;
  final String subtitle;

  GenericSummary(
      {Key? key,
      required this.image,
      required this.title,
      required this.subtitle,
      Widget? secondWidget,
      double? textRatio,
      double? imgRatio})
      : rightWidget = secondWidget ?? Container(),
        textRatio = textRatio ?? 1.0,
        imgRatio = imgRatio ?? 1.0,
        super(key: key);

  factory GenericSummary.only(
      {required double ratio,
      required ImageProvider image,
      required String title,
      required String subtitle,
      Widget? secondWidget}) {
    return GenericSummary(
      image: image,
      title: title,
      subtitle: subtitle,
      secondWidget: secondWidget,
      textRatio: ratio,
      imgRatio: ratio,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: image,
                    maxRadius: 40 * imgRatio,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(4 * textRatio)),
                          Text(
                            title,
                            style: TextStyle(fontSize: 20 * textRatio),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Padding(padding: EdgeInsets.all(2 * textRatio)),
                          Text(
                            subtitle,
                            style: TextStyle(
                                fontSize: 18 * textRatio,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  rightWidget,
                ]),
          ],
        ));
  }
}
