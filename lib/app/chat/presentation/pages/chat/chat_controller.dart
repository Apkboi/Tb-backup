import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/chat/domain/models/dtos/get_chats_res_dto.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';
import 'package:triberly/app/chat/domain/services/chat_imp_service.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/di/di.dart';

class ChatController extends StateNotifier<ChatState> {
  ChatController(this.ref, this._chatImpService) : super(ChatInitial());
  final StateNotifierProviderRef ref;
  final ChatImpService _chatImpService;

  List<ChatData> chats = [];
  List<ChatData> chatSearchResults = [];
  ChatData? initiatedChat;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  List<MessageModel> messagesList = [];

  Future<void> getChats() async {
    try {
      state = ChatLoading();
      final response = await _chatImpService.getChats();
      chats = response?.callData?.data ?? [];
      chatSearchResults = response?.callData?.data ?? [];

      final chatInfo = await Future.wait(chats.map((chat) async {
        final lastMessageData = await getLastMessage(chat.id.toString());
        return {
          'lastMessage': lastMessageData['message'] ?? '-',
          'timestamp': lastMessageData['timestamp'] ?? '0',
        };
      }));

      for (int i = 0; i < chats.length; i++) {
        chats[i].lastMessage = chatInfo[i]['lastMessage'];
        chats[i].timestamp = chatInfo[i]['timestamp'];
      }

      state = ChatSuccess();
    } catch (e) {
      state = ChatError(e.toString());
    }
  }

  Future<void> searchForChat(String text) async {
    state = ChatLoading();
    if (text.isEmpty) {
      chatSearchResults = chats;
    }

    final result = chats
        .where((element) =>
            "${element.participants?.firstOrNull?.user?.firstName} ${element.participants?.firstOrNull?.user?.lastName}"
                .toLowerCase()
                .contains(text.toLowerCase()))
        .toList();
    logger.e(result.length);

    chatSearchResults = result;

    state = ChatSuccess();
  }
  bool isConnectedToUser(String email){
    logger.e(email);
    return chats
        .where((element) =>
    element.participants?.first.user?.email == email)
    .toList().length!=0;
  }

  Future<Map<String, dynamic>> getLastMessage(String chatId) async {
    try {
      final lastMessageSnapshot = await dbRef
          .child("chat_messages")
          .child(chatId)
          .orderByChild('timestamp')
          .limitToLast(1)
          .once();

      if (!lastMessageSnapshot.snapshot.exists) {
        return {
          'message': null,
          'timestamp': null,
        };
      }

      final lastMessageData = lastMessageSnapshot.snapshot.value;
      final lastMessageList = MessageModel.parseMessagesFromJson(
        jsonDecode(jsonEncode(lastMessageData)),
      );

      if (lastMessageList.isEmpty) {
        return {
          'message': null,
          'timestamp': null,
        };
      }

      lastMessageList.sort(
        (a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)),
      );

      final lastMessage = lastMessageList.last;

      return {
        'message':
            (lastMessage.message?.isURL ?? false) ? '-' : lastMessage.message,
        'timestamp': lastMessage.date, // Adjust this to the correct field
      };
    } catch (e) {
      return {
        'message': null,
        'timestamp': null,
      };
    }
  }

  // Future<void> getChats() async {
  //   try {
  //     state = ChatLoading();
  //     final response = await _chatImpService.getChats();
  //     chats = response?.callData?.data ?? [];
  //
  //     final lastMessages = <String, String?>{}; // Map chatId to last message
  //
  //     await Future.forEach(chats, (chat) async {
  //       final lastMessage = await getLastMessage(chat.id.toString());
  //       lastMessages[chat.id.toString()] = lastMessage;
  //     });
  //
  //     // Assign last messages to chats
  //     chats.forEach((chat) {
  //       chat.lastMessage = lastMessages[chat.id.toString()] ?? '-';
  //     });
  //
  //     state = ChatSuccess();
  //   } catch (e) {
  //     state = ChatError(e.toString());
  //   }
  // }
  //
  // Future<String?> getLastMessage(String chatId) async {
  //   try {
  //     final lastMessageSnapshot = await dbRef
  //         .child("chat_messages")
  //         .child(chatId)
  //         .orderByChild('timestamp')
  //         .limitToLast(1)
  //         .once();
  //
  //     if (!lastMessageSnapshot.snapshot.exists) {
  //       return null;
  //     }
  //
  //     final lastMessageData = lastMessageSnapshot.snapshot.value;
  //     final lastMessageList = MessageModel.parseMessagesFromJson(
  //       jsonDecode(jsonEncode(lastMessageData)),
  //     );
  //
  //     if (lastMessageList.isEmpty) {
  //       return null;
  //     }
  //
  //     lastMessageList.sort(
  //       (a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)),
  //     );
  //
  //     if (lastMessageList.last.message?.isURL ?? true) {
  //       return null;
  //     }
  //     return lastMessageList.last.message;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future<void> initiateChat(String userId) async {
    try {
      state = InitialiseChatLoading();

      final response = await _chatImpService.initiateChat(userId);
      initiatedChat = response?.data;

      state = InitialiseChatSuccess();
    } catch (e) {
      state = ChatError(e.toString());
    }
  }
}

final chatProvider = StateNotifierProvider<ChatController, ChatState>((ref) {
  return ChatController(ref, sl());
});

final isConnectedToUserProvider = Provider.family<bool, String>(
  (ref, id) {
    logger.e(id);

    return ref
        .read(chatProvider.notifier)
        .chats
        .where((element) =>
            element.participants?.first.user?.email == id)
        .isNotEmpty;
  },
);

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSearch extends ChatState {}

class ChatSuccess extends ChatState {}

class InitialiseChatLoading extends ChatState {}

class InitialiseChatSuccess extends ChatState {}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}

class LastMessagesLoading extends ChatState {}

class LastMessagesSuccess extends ChatState {}

class LastMessagesError extends ChatState {
  final String message;

  LastMessagesError(this.message);
}
