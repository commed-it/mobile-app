import 'package:flutter/material.dart';

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
                          Padding(padding: EdgeInsets.all(6 * textRatio)),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 20 * textRatio,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(2 * textRatio)),
                          Text(
                            subtitle,
                            style: TextStyle(
                                fontSize: 20 * textRatio,
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

class ListDivider extends StatelessWidget {
  const ListDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.0,
      thickness: 0.0,
      indent: 20,
      endIndent: 20,
    );
  }
}

class GenSummaryButton extends StatelessWidget {
  final Widget rightWidget;
  final double textRatio;
  final double imgRatio;
  final ImageProvider image;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  GenSummaryButton(
      {Key? key,
        required this.image,
        required this.title,
        required this.subtitle,
        required this.onPressed,
        Widget? secondWidget,
        double? textRatio,
        double? imgRatio})
      : textRatio = textRatio ?? 1.0,
        rightWidget = secondWidget ?? Container(),
        imgRatio = imgRatio ?? 1.0,
        super(key: key);

  factory GenSummaryButton.only(
      {required double ratio,
        required ImageProvider image,
        required String title,
        required String subtitle,
        required VoidCallback onPressed,
        Widget? secondWidget}) {
    return GenSummaryButton(
      image: image,
      title: title,
      subtitle: subtitle,
      secondWidget: secondWidget,
      textRatio: ratio,
      imgRatio: ratio,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13),
        child: GenericSummary.only(
          ratio: textRatio,
          image: image,
          title: title,
          subtitle: subtitle,
        ),
      ),
    );
  }
}
