class MessageModel {
  final String? message;
  final String? senderId;
  final bool isMe;
  final String? extraData;
  final String type;
  final MessageModel? repliedMessage;

  final String? date;
  final Map? timestamp;

  MessageModel({
    this.senderId,
    this.extraData,
    this.type = 'text',
    this.message,
    this.repliedMessage,
    this.isMe = true,
    this.date,
    this.timestamp,
  });

  static List<MessageModel> parseMessagesFromJson(Map<String, dynamic> json) {
    final List<MessageModel> messagesList = [];

    json.forEach((messageKey, messageData) {
      if (messageData is Map<String, dynamic>) {
        final messageModel = MessageModel(
          message: messageData['message'],
          isMe: messageData['isMe'],
          date: messageData['date'],
          senderId: messageData['senderId'],
          type: messageData['type'],
        );
        messagesList.add(messageModel);
      }
    });

    return messagesList;
  }

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'senderId': this.senderId,
      'isMe': this.isMe,
      'extraData': this.extraData,
      'type': this.type,
      'repliedMessage': this.repliedMessage,
      'date': this.date,
      'timestamp': this.timestamp,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      senderId: map['senderId'] as String,
      isMe: map['isMe'] as bool,
      extraData: map['extraData'] as String,
      type: map['type'] as String,
      repliedMessage: map['repliedMessage'] as MessageModel,
      date: map['date'] as String,
      timestamp: map['timestamp'] as Map,
    );
  }
}
