
import 'package:flutter_app/chat/conversation/model.dart';
import 'package:flutter_app/chat/models.dart';
import 'package:flutter_app/store/actions.dart';

class SetListChat extends AppAction {
  final List<ChatItemModel> chatModel;
  const SetListChat(this.chatModel);
}

class NavigateToChat extends AppAction {
  final ChatModel chatModel;
  const NavigateToChat(this.chatModel);
}

class SetListMessages extends AppAction {
  final List<MessageModel> msgs;
  const SetListMessages(this.msgs);
}

class ClearSearch extends AppAction {
  const ClearSearch();
}