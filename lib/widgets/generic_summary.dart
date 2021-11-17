import 'package:flutter/material.dart';
import 'package:flutter_app/store/store.dart';
import 'package:flutter_app/store/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';

class GenericSummary extends StatelessWidget {
  final Widget rightWidget;
  final double textRatio;
  final double imgRatio;
  final ImageProvider image;
  final String title;
  final String subtitle;
  final VoidCallback onPressedLogo;

  GenericSummary({Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressedLogo,
    Widget? secondWidget,
    double? textRatio,
    double? imgRatio}) :
        rightWidget = secondWidget ?? Container(),
        textRatio = textRatio ?? 1.0,
        imgRatio = imgRatio ?? 1.0,
        super(key: key);

  factory GenericSummary.only({required double ratio,
    required ImageProvider image,
    required String title,
    required String subtitle,
    required VoidCallback onPressedLogo,
    Widget? secondWidget}) {
    return GenericSummary(
      image: image,
      title: title,
      subtitle: subtitle,
      onPressedLogo: onPressedLogo,
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
            Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: CircleAvatar(
                      backgroundImage: image,
                      maxRadius: 40 * imgRatio,
                    ),
                    onTap: onPressedLogo,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: StoreConnector<AppState, CommedTheme>(
                      converter: (s) => s.state.theme,
                      builder: themedGenericSummary,
                    ),
                  ),
                  rightWidget,
                ]),
          ],
        ));
  }

  Widget themedGenericSummary(ctx, theme) =>
      Container(
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
                color: theme.background.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.all(2 * textRatio)),
            Text(
              subtitle,
              style: TextStyle(
                  fontSize: 20 * textRatio,
                  color: theme.background.subtitleColor,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      );
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
  final VoidCallback onPressedLogo;

  GenSummaryButton({Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.onPressedLogo,
    Widget? secondWidget,
    double? textRatio,
    double? imgRatio})
      : textRatio = textRatio ?? 1.0,
        rightWidget = secondWidget ?? Container(),
        imgRatio = imgRatio ?? 1.0,
        super(key: key);

  factory GenSummaryButton.only({required double ratio,
    required ImageProvider image,
    required String title,
    required String subtitle,
    required VoidCallback onPressed,
    required VoidCallback onPressedLogo,
    Widget? secondWidget}) {
    return GenSummaryButton(
      image: image,
      title: title,
      onPressed: onPressed,
      onPressedLogo: onPressedLogo,
      subtitle: subtitle,
      secondWidget: secondWidget,
      textRatio: ratio,
      imgRatio: ratio,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 13),
        child: GenericSummary.only(
          ratio: textRatio,
          image: image,
          title: title,
          subtitle: subtitle,
          onPressedLogo: onPressedLogo,
          secondWidget: rightWidget,
        ),
      ),
    );
  }
}
