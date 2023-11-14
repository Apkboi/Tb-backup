class MessageModel {
  final String? message;
  final String? senderId;
  final bool isMe;
  final bool isLocal;
  final String? extraData;
  final String type;
  final RepliedMessageModel? repliedMessage;
  final List<String>? files;

  final String? date;
  final Map? timestamp;

  MessageModel( {
    this.senderId,
    this.files,
    this.extraData,
    this.type = 'text',
    this.message,
    this.repliedMessage,
    this.isMe = true,
    this.isLocal = false,
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
          files: (messageData['files'] != null) ? List<String>.from(messageData["files"]) : []
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
      'files': files != null ? List<dynamic>.from(files!.map((x) => x)) : [],
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      senderId: map['senderId'] as String,
      isMe: map['isMe'] as bool,
      type: map['type'] as String,
      date: map['date'] as String,
      files: (map['files'] != null) ? List<String>.from(map["files"]) : [],

    );
  }

  MessageModel copyWith({
    String? message,
    String? senderId,
    bool? isMe,
    bool? isLoading,
    String? extraData,
    String? type,
    RepliedMessageModel? repliedMessage,
    String? date,
    Map? timestamp,
    final List<String>? files

  }) {
    return MessageModel(
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      isMe: isMe ?? this.isMe,
      extraData: extraData ?? this.extraData,
      type: type ?? this.type,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      date: date ?? this.date,
      timestamp: timestamp ?? this.timestamp,
      files: files ?? this.files,
      isLocal: isLoading ?? this.isLocal,
    );
  }
}

class RepliedMessageModel {
  final String? message;
  final String? senderName;
  final bool isMe;
  final String? date;
  final String? type;
  final List<String>? files;

  RepliedMessageModel({
    this.type = 'text',
    this.message,
    this.senderName,
    this.isMe = true,
    this.date,
    this.files,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'senderName': this.senderName,
      'isMe': this.isMe,
      'date': this.date,
      'type': this.type,
      'files': files != null ? List<dynamic>.from(files!.map((x) => x)) : [],
    };
  }

  factory RepliedMessageModel.fromMap(Map<String, dynamic> map) {
    return RepliedMessageModel(
      message: map['message'] as String?,
      senderName:
          (map['senderName'] != null) ? map['senderName'] as String : 'n/a',
      isMe: map['isMe'] as bool,
      date: map['date'] as String,
      type: map['type'] as String,
      files: (map['files'] != null) ? List<String>.from(map["files"]) : [],
    );
  }
}
