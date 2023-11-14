import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';
import 'package:triberly/core/services/image_manipulation/cloudinary_manager.dart';
import 'package:triberly/core/shared/custom_dialogs.dart';

class ChatDetailsController extends StateNotifier<ChatDetailsState> {
  ChatDetailsController(this.ref) : super(ChatDetailsInitial());

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  final StateNotifierProviderRef ref;

  RepliedMessageModel? replyingMessage;

  List<MessageModel> messagesList = [];

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

  Future<void> caller(String chatId) async {
    state = ChatDetailsLoading();

    try {
      dbRef
          .child("chat_messages")
          .child(chatId)
          .orderByChild(
            'timestamp',
          )
          .limitToLast(25)
          .onValue
          .listen((data) {
        state = ChatDetailsLoading();

        if (!data.snapshot.exists) {
          messagesList = [];

          state = ChatDetailsSuccess();
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

  Future<void> sendChatMessage(
    MessageModel data,
    String chatId,
  ) async {
    if (data.message == '') {
      CustomDialogs.showToast('Add a text');
      return;
    }

    addChat(data.copyWith(isLoading: true));

    if (data.files != null && data.files!.isNotEmpty) {
      var url =
          await Future.wait(data.files!.map((e) => CloudinaryManager.uploadFile(
                filePath: e,
                file: File(e),
              )));

      data = data.copyWith(files: url);
    }

    dbRef
        .child("chat_messages")
        .child(chatId)
        .push()
        .set(data.copyWith().toMap())
        .then(
          (value) {},
        );
  }

  void addChat(
    MessageModel data,
  ) {
    messagesList.add(data.copyWith(isLoading: true));

    state = ChatDetailsSuccess();
  }
}

final chatDetailsProvider =
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
