
import 'package:flutter_app/chat/models.dart';
import 'package:flutter_app/store/actions.dart';

class SetListChat extends AppAction {
  final List<ChatModel> chatModel;
  const SetListChat(this.chatModel);
}