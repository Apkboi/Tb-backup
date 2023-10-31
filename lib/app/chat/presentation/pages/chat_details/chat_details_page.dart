import 'dart:convert';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:collection/collection.dart';
import 'package:triberly/app/auth/data/datasources/user_dao.dart';
import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/app/chat/data/datasources/audio_dao_datasource.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';
import 'package:triberly/app/chat/external/datasources/audio_dao_imp_datasource.dart';
import 'package:triberly/app/chat/presentation/widgets/wave_bubble.dart';

import 'package:triberly/core/_core.dart';
import 'package:triberly/core/services/image_manipulation/cloudinary_manager.dart';

import '../../widgets/_chat_widgets.dart';
import 'chat_details_controller.dart';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

const String testSenderid = 'asdadsa-1233-sdas332-2sasd';
const String anotherSenderid = 'another-1233-sender-1234';

class ChatDetailsPage extends ConsumerStatefulWidget {
  const ChatDetailsPage({
    super.key,
    required this.chatId,
    this.userName,
    // required this.userId,
  });

  final String chatId;
  final String? userName;
  // final String? userId;

  @override
  ConsumerState createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends ConsumerState<ChatDetailsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  final TextEditingController messageCtrl = TextEditingController();
  final ScrollController listViewScrollController = ScrollController();
  List<MessageModel> messagesList = [];

  late PlayerController playerController;

  ///Audio
  ///
  late RecorderController recorderController;

  final userDto = sl<UserImpDao>().user;

  String? path;
  // String? musicFile;
  ValueNotifier<bool> isRecording = ValueNotifier(false);
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;
  @override
  void initState() {
    super.initState();
    messageCtrl.addListener(() {
      setState(() {});
    });

    playerController = PlayerController();
    getChats();
    _getDir();
    _initialiseControllers();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    dialogKey.currentState?.dispose();
    recorderController.dispose();

    messageCtrl.dispose();
    super.dispose();
  }

  getChats() {
    Future.delayed(Duration.zero, () {
      ref.read(chatDetailsProvider.notifier).caller(widget.chatId);
    });
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}.m4a";
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    logger.e(widget.chatId);
    return Scaffold(
      body: Scaffold(
        // key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        appBar: ChatDetailsAppbar(
          name: widget.userName ?? '',
        ),
        body: Column(
          children: [
            const CustomDivider(),
            Consumer(
              builder: (context, ref, child) {
                if (ref.watch(chatDetailsProvider) is ChatDetailsLoading) {
                  return Expanded(child: CustomDialogs.getLoading(size: 50));
                }
                messagesList =
                    ref.watch(chatDetailsProvider.notifier).messagesList;

                messagesList = ref
                    .read(chatDetailsProvider.notifier)
                    .addDateSeparators(messagesList);

                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: listViewScrollController,
                    itemCount: messagesList.length,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemBuilder: (context, index) {
                      List<MessageModel> normalList =
                          messagesList.reversed.toList();

                      MessageModel singleItem = normalList[index];

                      if (singleItem.message == null &&
                          singleItem.type == 'text') {
                        return Center(
                          child: TextView(
                            text: TimeUtil.formatDate(
                              singleItem.date.toString(),
                            ),
                          ),
                        );
                      }
                      singleItem = normalList[index];

                      if (singleItem.type == 'audio') {
                        return WaveBubble(
                          // controller: playerController,
                          index: index,
                          isSender:
                              singleItem.senderId == userDto?.id.toString(),
                          audioUrl: singleItem.message ?? '',
                        );
                      }
                      singleItem = normalList[index];

                      return MessageItem(
                        message: singleItem,
                        isMe: singleItem.senderId == userDto?.id.toString(),
                        onRightSwipe: () {
                          // logger.e(singleItem.message);
                          setState(() {
                            ref
                                .read(chatDetailsProvider.notifier)
                                .replyingMessage = RepliedMessageModel(
                              senderName: 'mc_olumo',
                              isMe: true,
                              date: singleItem.date,
                              message: singleItem.message,
                              type: singleItem.type,
                            );

                            logger.e(ref
                                .read(chatDetailsProvider.notifier)
                                .replyingMessage
                                ?.message);
                          });
                        },
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: isRecording,
          builder: (context, value, child) {
            return ChatBottomActionsBar(
              messageCtrl: messageCtrl,
              isRecording: value,
              audioCtrl: recorderController,
              onSend:
                  (messageCtrl.text.isEmpty) ? _startOrStopRecording : onSend,
            );
          },
        ),
      ),
    );
  }

  void _startOrStopRecording() async {
    try {
      if (isRecording.value) {
        recorderController.reset();

        final path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          logger.wtf(path);

          final url = await CloudinaryManager.uploadFile(
            filePath: path,
            file: File(path),
          );

          logger.i(url);
          final data = MessageModel(
            message: url,
            type: 'audio',
            senderId: userDto?.id.toString(),
            isMe: true,
            repliedMessage:
                ref.read(chatDetailsProvider.notifier).replyingMessage,
            date: DateTime.now().toString(),
            timestamp: ServerValue.timestamp,
          );

          dbRef
              .child("chat_messages")
              .child(widget.chatId)
              .push()
              .set(data.toMap())
              .then(
                (value) {},
              );
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
        }
      } else {
        await recorderController.record(path: path);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isRecordingCompleted = false;
      isRecording.value = !isRecording.value;

      // setState(() {
      // });
    }
  }

  onSend() {
    final data = MessageModel(
      message: messageCtrl.text,
      senderId: userDto?.id.toString(),
      isMe: true,
      repliedMessage: ref.read(chatDetailsProvider.notifier).replyingMessage,
      date: DateTime.now().toString(),
      timestamp: ServerValue.timestamp,
    );

    if (data.message == '') {
      CustomDialogs.showToast('Add a text');
      return;
    }

    dbRef
        .child("chat_messages")
        .child(widget.chatId)
        .push()
        .set(data.toMap())
        .then(
          (value) {},
        );

    ///Clear textfield
    messageCtrl.clear();
    ref.read(chatDetailsProvider.notifier).replyingMessage = null;
  }
}
