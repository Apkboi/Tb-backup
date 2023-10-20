class MessageModel {
  final String? message;
  final String? senderId;
  final bool isMe;
  final String? extraData;
  final String type;
  final RepliedMessageModel? repliedMessage;

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
          repliedMessage: (messageData['repliedMessage'] != null)
              ? RepliedMessageModel.fromMap(messageData['repliedMessage'])
              : null,
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
      'repliedMessage': this.repliedMessage?.toMap(),
      'date': this.date,
      'timestamp': this.timestamp,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      senderId: map['senderId'] as String,
      isMe: map['isMe'] as bool,
      type: map['type'] as String,
      date: map['date'] as String,
    );
  }
}

class RepliedMessageModel {
  final String? message;
  final String? senderName;
  final bool isMe;
  final String? date;
  final String? type;

  RepliedMessageModel({
    this.type = 'text',
    this.message,
    this.senderName,
    this.isMe = true,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'senderName': this.senderName,
      'isMe': this.isMe,
      'date': this.date,
      'type': this.type,
    };
  }

  factory RepliedMessageModel.fromMap(Map<String, dynamic> map) {
    return RepliedMessageModel(
      message: map['message'] as String,
      senderName:
          (map['senderName'] != null) ? map['senderName'] as String : 'n/a',
      isMe: map['isMe'] as bool,
      date: map['date'] as String,
      type: map['type'] as String,
    );
  }
}
