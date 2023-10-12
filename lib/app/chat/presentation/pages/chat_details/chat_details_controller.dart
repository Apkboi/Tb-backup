import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';

import '../../../../../core/services/di/di.dart';
import 'chat_details_page.dart';

// List<MessageModel> parseMessagesFromJson(Map<String, dynamic> json) {
//   final List<MessageModel> messagesList = [];
//
//   json.forEach((messageKey, messageData) {
//     if (messageData is Map<String, dynamic>) {
//       final messageModel = MessageModel(
//         message: messageData['message'],
//         isMe: messageData['isMe'],
//         date: messageData['date'],
//         senderId: messageData['senderId'],
//         type: messageData['type'],
//       );
//       messagesList.add(messageModel);
//     }
//   });
//   return messagesList;
// }

class ChatDetailsController extends StateNotifier<ChatDetailsState> {
  ChatDetailsController(this.ref) : super(ChatDetailsInitial());

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  final StateNotifierProviderRef ref;

  MessageModel? replyingMessage;

  List<MessageModel> messagesList = [
    MessageModel(
      message: 'I need help with my homework.',
      isMe: false,
      date: DateTime(2023, 1, 10).toString(),
    ),
    MessageModel(
      message: 'Okay',
      isMe: true,
      date: DateTime(2023, 1, 10).toString(),
    ),
    MessageModel(
      message: 'What do you need?',
      isMe: true,
      date: DateTime(2023, 1, 10).toString(),
    ),
    MessageModel(
      message: 'Good morning!',
      isMe: false,
      date: DateTime(2023, 1, 11).toString(),
    ),
    MessageModel(
      message: 'Hi there!',
      isMe: true,
      date: DateTime(2023, 1, 11).toString(),
    ),
    MessageModel(
      message: 'How are you today?',
      isMe: true,
      date: DateTime(2023, 1, 11).toString(),
    ),
    MessageModel(
      message: 'Happy Wednesday!',
      isMe: false,
      date: DateTime(2023, 1, 12).toString(),
    ),
    MessageModel(
      message: 'Hello!',
      isMe: true,
      date: DateTime(2023, 1, 12).toString(),
    ),
    MessageModel(
      message: 'Im doing well, thanks!',
      isMe: true,
      date: DateTime(2023, 1, 12).toString(),
    ),
    MessageModel(
      message: 'Whats on your mind?',
      isMe: false,
      date: DateTime(2023, 1, 13).toString(),
    ),
    MessageModel(
      message: 'Not much, just working on a project.',
      isMe: true,
      date: DateTime(2023, 1, 13).toString(),
    ),
    MessageModel(
      message: 'That sounds interesting!',
      isMe: false,
      date: DateTime(2023, 1, 13).toString(),
    ),
    MessageModel(
      message: 'Yes, its quite challenging but rewarding.',
      isMe: true,
      date: DateTime(2023, 1, 13).toString(),
    ),
    MessageModel(
      message: 'Happy Friday!',
      isMe: false,
      date: DateTime(2023, 1, 14).toString(),
    ),
    MessageModel(
      message: 'Hello!',
      isMe: true,
      date: DateTime(2023, 1, 14).toString(),
    ),
  ];

  List<MessageModel> addDateSeparators(List<MessageModel> messagesList) {
    List<MessageModel> updatedMessagesList = [];

    if (messagesList.isEmpty) {
      return updatedMessagesList;
    }

    // Initialize the first date as the date of the first message
    DateTime? currentDate =
        DateTime.parse(messagesList[0].date ?? DateTime.now().toString());

    for (int i = 0; i < messagesList.length; i++) {
      final message = messagesList[i];
      final messageDate =
          DateTime.parse(message.date ?? DateTime.now().toString());

      // Check if the current message's date is different from the previous one
      if (!DateUtils.isSameDay(currentDate, messageDate)) {
        // Check if a date separator for this day already exists in the list
        bool separatorExists = updatedMessagesList.any((msg) =>
            msg.message == null &&
            msg.type == 'text' &&
            DateUtils.isSameDay(
                DateTime.parse(msg.date ?? DateTime.now().toString()),
                messageDate));

        // If a separator doesn't exist, add it
        if (!separatorExists) {
          updatedMessagesList.add(
            MessageModel(
              message: null,
              type: 'text',
              date: messageDate.toString(),
            ),
          );
        }

        // Update the current date to the new date
        currentDate = messageDate;
      }

      // Add the current message to the updated list
      updatedMessagesList.add(message);
    }

    return updatedMessagesList;
  }

  Future<void> caller() async {
    try {
      dbRef
          .child("chat_messages")
          .child("test_chat_id_1")
          .orderByChild(
            'timestamp',
          )
          .onValue
          .listen((data) {
        state = ChatDetailsLoading();

        if (!data.snapshot.exists) {
          return;
        }

        final datavalue2 = MessageModel.parseMessagesFromJson(
          jsonDecode(
            jsonEncode(data.snapshot.value),
          ),
        );

        datavalue2.sort(
          (a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)),
        );

        messagesList = datavalue2;

        state = ChatDetailsSuccess();
      }).onError((handleError) {
        state = ChatDetailsError(handleError.toString());
      });
    } catch (e) {
      state = ChatDetailsError(e.toString());
    }
  }
}

final chat_detailsProvider =
    StateNotifierProvider<ChatDetailsController, ChatDetailsState>((ref) {
  return ChatDetailsController(ref);
});

abstract class ChatDetailsState {}

class ChatDetailsInitial extends ChatDetailsState {}

class ChatDetailsLoading extends ChatDetailsState {}

class ChatDetailsSuccess extends ChatDetailsState {}

class ChatDetailsError extends ChatDetailsState {
  final String message;

  ChatDetailsError(this.message);
}
