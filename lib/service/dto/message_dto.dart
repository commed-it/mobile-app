import 'dart:convert';

import 'formal_offer_dto.dart';

class MessageDTO {
  final int userId;
  final String channelId;
  final ConvItemContentDTO msg;
  final String timestamp;

  MessageDTO({
    required this.userId,
    required this.channelId,
    required this.msg,
    required this.timestamp,
  });

  factory MessageDTO.fromJson(Map<String, dynamic> json) {
    var jsonContent = jsonDecode(json['msg']);
    var type = jsonContent['type'];
    ConvItemContentDTO? content;
    if (type == 'message') {
      content = MessageContentDTO.fromJson(jsonContent);
    } else {
      content = MessageFormalOfferDTO.fromJson(jsonContent);
    }
    return MessageDTO(
      userId: json['author'] as int,
      channelId: json['channel_context'] as String,
      msg: content,
      timestamp: json['timestamp'] as String,
    );
  }
}

class ConvItemContentDTO {
  final String type;

  ConvItemContentDTO(this.type);
}

class MessageContentDTO extends ConvItemContentDTO {
  final int user;
  final String message;

  MessageContentDTO(this.user, String type, this.message) : super(type);

  factory MessageContentDTO.fromJson(Map<String, dynamic> json) {
    return MessageContentDTO(json['user'] as int,
        json['type'] as String, json['message'] as String);
  }
}

class MessageFormalOfferDTO extends ConvItemContentDTO {
  final int user;
  final FormalOfferDTO formalOffer;

  MessageFormalOfferDTO(String type, this.user, this.formalOffer) : super(type);

  factory MessageFormalOfferDTO.fromJson(Map<String, dynamic> json) {
    return MessageFormalOfferDTO(
        json['type'], json['user'], FormalOfferDTO.fromJson(json['formalOffer']));
  }
}
