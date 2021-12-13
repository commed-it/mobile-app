class MessageDTO {
  final int userId;
  final String channelId;
  final String msg;
  final String timestamp;

  MessageDTO({
    required this.userId,
    required this.channelId,
    required this.msg,
    required this.timestamp,
  });

  factory MessageDTO.fromJson(Map<String, dynamic> json) {
    return MessageDTO(
      userId: json['author'] as int,
      channelId: json['channel_context'] as String,
      msg: json['msg'] as String,
      timestamp: json['timestamp'] as String,
    );
  }
}

class MessageContentDTO {

}