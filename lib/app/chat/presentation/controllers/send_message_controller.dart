import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/image_manipulation/cloudinary_manager.dart';
import 'package:triberly/core/shared/custom_dialogs.dart';

abstract class SenMessageState {}

class SendMessageController extends StateNotifier<SenMessageState> {
  SendMessageController() : super(SendMessageInitial());

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  Future<void> sendChatMessage(
    MessageModel data,
    String chatId,
  ) async {

    logger.e('CALLED SEND MESSAGE');
    if (data.message == '') {
      CustomDialogs.showToast('Add a text');
      return;
    }

    state = SendMessageLoading();

    try {
      if (data.files != null && data.files!.isNotEmpty) {
        var url = await Future.wait(
            data.files!.map((e) => CloudinaryManager.uploadFile(
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
        (value) {
          state = SendMessageSent();
        },
      );
    } on Exception catch (e) {
      logger.e(e);
      state = SendMessageFailed(e.toString());
    }
  }
}

class SendMessageInitial extends SenMessageState {}

class SendMessageLoading extends SenMessageState {}

class SendMessageFailed extends SenMessageState {
  final String error;

  SendMessageFailed(this.error);
}

class SendMessageSent extends SenMessageState {}
