

import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

class SearcherIs implements AppAction {
  final String searcher;

  SearcherIs(this.searcher);

}

class DeleteRecommendationIndex implements AppAction{
  final int index;

  DeleteRecommendationIndex(this.index);

}


AppState searcherReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case DeleteRecommendationIndex:
      var actionD = action as DeleteRecommendationIndex;
      if (actionD.index < prev.searcher.historic.length) {
        var removeAt = prev.searcher.historic.toList()
          ..removeAt(actionD.index);
        return prev.copy(searcher: prev.searcher.copy(historic: removeAt));
      }
      return prev;
    case SearcherIs:
      var searcherIs = action as SearcherIs;
      return prev.copy(
          searcher: prev.searcher.copy(searcher: searcherIs.searcher));
  }
  return prev;
}
