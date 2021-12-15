
import 'package:flutter_app/chat/conversation/model.dart';
import 'package:flutter_app/chat/models.dart';
import 'package:flutter_app/store/actions.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SetListChat extends AppAction {
  final List<ChatItemModel> chatModel;
  const SetListChat(this.chatModel);
}

class NavigateToChat extends AppAction {
  final ChatModel chatModel;
  const NavigateToChat(this.chatModel);
}

class SetChatModel extends AppAction {
  final ChatModel chatModel;
  const SetChatModel(this.chatModel);
}


class SetListMessages extends AppAction {
  final List<CommedMessage> msgs;
  const SetListMessages(this.msgs);
}

class AddListMessages extends AppAction {
  final CommedMessage msg;
  const AddListMessages(this.msg);
}

class ClearSearch extends AppAction {
  const ClearSearch();
}

class SetEncounterChannel extends AppAction {
  final String idEncounter;
  final WebSocketChannel webSocketChannel;
  const SetEncounterChannel(this.idEncounter, this.webSocketChannel);
}

class AddChannel extends AppAction {
  final WebSocketChannel channel;
  final String idEncounter;
  AddChannel(this.idEncounter, this.channel);
}

class SetSenderMessage extends AppAction {
  final String msg;
  const SetSenderMessage(this.msg);
}