// This class contains the theme that will be used in the app. If you ever need
// to put some product with a color, text over this color, sub title, or
// everything like that you should pass it to avoid being a pain in the ass to
// change the theme

import 'package:flutter/material.dart';

class ColorText {
  final Color color;
  final Color textColor;

  ColorText(this.color, this.textColor);

  Color get subtitleColor => Color.alphaBlend(textColor.withAlpha(221), color);
}

class CommedTheme {
  final ColorText primary;
  final ColorText accent;
  final ColorText background;
  final Color lightBackground;
  final Color unselectedLabel;
  final ColorText link;
  final Color appBarColor;

  CommedTheme(this.primary, this.accent, this.background, this.lightBackground,
      this.unselectedLabel, this.link, this.appBarColor);

  CommedTheme copy({
    ColorText? primary,
    ColorText? accent,
    ColorText? background,
    Color? unselectedLabel,
    ColorText? link,
    Color? appBarColor,
    Color? lightBackground,
  }) =>
      CommedTheme(
          primary ?? this.primary,
          accent ?? this.accent,
          background ?? this.background,
          lightBackground ?? this.lightBackground,
          unselectedLabel ?? this.unselectedLabel,
          link ?? this.link,
          appBarColor ?? this.appBarColor);

  CommedTheme.init()
      : primary = ColorText(Colors.teal, Colors.white),
        accent = ColorText(Colors.yellow.shade700, Colors.black),
        background = ColorText(Colors.white, Colors.black),
        lightBackground = const Color.fromARGB(255, 0xe5, 0xe5, 0xe5),
        unselectedLabel = const Color.fromARGB(255, 0x95, 0x95, 0x95),
        link = ColorText(Colors.white, Color.fromARGB(0xff, 0xC, 0x6A, 0xd2)),
        appBarColor = Colors.teal;
}
