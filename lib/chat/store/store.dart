import 'package:flutter_app/store/actions.dart';
import 'package:flutter_app/store/store.dart';

import 'actions.dart';

AppState ListChatReducer(AppState prev, AppAction action) {
  switch (action.runtimeType) {
    case SetListChat:
      action = action as SetListChat;
      return prev.copy(listChats: action.chatModel);
    default:
      return prev;
  }
}
