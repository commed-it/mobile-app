import 'package:flutter/cupertino.dart';

class Searcher {
  final String text;
  final List<String> historic;

  Searcher(this.text, this.historic);

  Searcher.init()
      : text = "",
        historic = List.generate(
            15, (index) => "This is a recommendation " + index.toString());

  Searcher copy({String? searcher, List<String>? historic}) =>
      Searcher(searcher ?? this.text,
          historic ?? this.historic);
}
