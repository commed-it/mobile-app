class Searcher {
  final String text;
  final List<String> historic;
  final bool hasSearched;
  final String textSearched;

  Searcher(this.text, this.historic, this.hasSearched, this.textSearched);

  Searcher.init()
      : text = "",
        historic = List.generate(
            15, (index) => "This is a recommendation " + index.toString()),
        hasSearched = false,
        textSearched = '';

  Searcher copy(
          {String? searcher,
          List<String>? historic,
          bool? hasSearched,
          String? textSearched}) =>
      Searcher(searcher ?? this.text, historic ?? this.historic,
          hasSearched ?? this.hasSearched, textSearched ?? this.textSearched);
}
