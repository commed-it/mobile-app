import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

import 'actions.dart';

AppState ListChatReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case SetListChat:
      action = action as SetListChat;
      return prev.copy(listChats: action.chatModel);
    case NavigateToChat:
      action = action as NavigateToChat;
      return prev.copy(
          navigatorKey: prev.navigatorKey
            ..currentState!.pushNamed(Routes.chat), chatModel: action.chatModel);
    default:
      return prev;
  }
}
