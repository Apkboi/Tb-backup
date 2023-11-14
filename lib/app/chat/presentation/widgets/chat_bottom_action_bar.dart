import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/auth/external/datasources/user_imp_dao.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';
import 'package:triberly/app/chat/presentation/pages/chat_details/chat_details_controller.dart';
import 'package:triberly/app/chat/presentation/pages/chat_details/chat_details_page.dart';
import 'package:triberly/app/chat/presentation/widgets/replying_message_widget.dart';
import 'package:triberly/core/_core.dart';

import '../../../../core/services/image_manipulation/image_manager.dart';

class ChatBottomActionsBar extends ConsumerStatefulWidget {
  const ChatBottomActionsBar({
    super.key,
    required this.messageCtrl,
    required this.chatId,
    this.onSend,
    this.isRecording = false,
    this.audioCtrl,
    this.replyingMessage,
  });

  final TextEditingController messageCtrl;
  final MessageModel? replyingMessage;
  final VoidCallback? onSend;
  final bool isRecording;
  final String chatId;
  final RecorderController? audioCtrl;

  @override
  ConsumerState<ChatBottomActionsBar> createState() =>
      _ChatBottomActionsBarState();
}

class _ChatBottomActionsBarState extends ConsumerState<ChatBottomActionsBar> {
  bool isAudio = true;
  final userDto = sl<UserImpDao>().user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.messageCtrl.addListener(() {
      if (widget.messageCtrl.text.isEmpty) {
        setState(() {
          isAudio = true;
        });
      } else {
        setState(() {
          isAudio = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return SafeArea(
          bottom: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ReplyingMessageWidget(),
              const CustomDivider(),
              Row(
                children: [
                  PopupMenuButton<int>(
                    onSelected: (value) {
                      _onSelected(value, context);
                    },
                    itemBuilder: (context) => [
                      // popupmenu item 1
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            const ImageWidget(
                                imageUrl: Assets.svgsImage, size: 20),
                            8.horizontalSpace,
                            const TextView(
                              text: 'Upload image',
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            const ImageWidget(
                                imageUrl: Assets.svgsVideo, size: 20),
                            8.horizontalSpace,
                            const TextView(
                              text: 'Upload video',
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: [
                            const ImageWidget(
                                imageUrl: Assets.svgsAudio, size: 20),
                            8.horizontalSpace,
                            const TextView(
                              text: 'Upload audio file',
                            )
                          ],
                        ),
                      ),
                    ],
                    offset: const Offset(0, 30),
                    // color: Colors.grey,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    child: const IconButton(
                        onPressed: null, icon: Icon(Icons.add)),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: widget.isRecording
                          ? AudioWaveforms(
                              enableGesture: true,
                              size: Size(
                                  MediaQuery.of(context).size.width / 2, 50),
                              recorderController: widget.audioCtrl!,
                              waveStyle: const WaveStyle(
                                waveColor: Colors.white,
                                extendWaveform: true,
                                showMiddleLine: false,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: const Color(0xFF1E1B26),
                              ),
                              padding: const EdgeInsets.only(left: 18),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                            )
                          : TextFormField(
                              maxLines: 3,
                              minLines: 1,
                              controller: widget.messageCtrl,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Pallets.chatTextFiledGrey,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 10.h,
                                ),
                              ),
                              onFieldSubmitted: (message) {
                                // sendMessage();
                              },
                            ),
                    ),
                  ),
                  12.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      widget.onSend!();
                    },
                    // onLongPress: () {
                    //   setState(() {
                    //     isAudio = !isAudio;
                    //   });
                    // },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 16),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        child: ImageWidget(
                          key: isAudio
                              ? const ValueKey<String>('audio')
                              : const ValueKey<String>('mic'),
                          imageUrl: isAudio
                              ? Assets.svgsMicrophone
                              : Assets.svgsPaperAirPlane,
                          size: 24,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  void _onSelected(int value, BuildContext context) {
    switch (value) {
      case 1:
        _pickImage(context);
      case 2:
        _pickVideo(context);
      case 3:
        _pickAudio(context);
    }
  }

  void _pickImage(BuildContext context) async {
    final imageManager = ImageManager();
    var image = await imageManager.showDocumentSourceDialog(context);

    final data = MessageModel(
      message:
          widget.messageCtrl.text.isNotEmpty ? widget.messageCtrl.text : null,
      type: 'image',
      senderId: userDto?.id.toString(),
      isMe: true,
      isLocal: false,
      repliedMessage: ref.read(chatDetailsProvider.notifier).replyingMessage,
      date: DateTime.now().toString(),
      files: image != null ? [image.path] : [],
      timestamp: ServerValue.timestamp,
    );

    if (image != null) {
      ref.read(chatDetailsProvider.notifier).addChat(
            data,
          );
    }
  }

  void _pickVideo(BuildContext context) async {
    final imageManager = ImageManager();
    var image = await imageManager.fetchFiles(
      fileType: FileType.video,
      // allowedExtensions: ["mp4", 3gp]
    );

    final data = MessageModel(
      message:
          widget.messageCtrl.text.isNotEmpty ? widget.messageCtrl.text : null,
      type: 'video',
      senderId: userDto?.id.toString(),
      isMe: true,
      isLocal: false,
      repliedMessage: ref.read(chatDetailsProvider.notifier).replyingMessage,
      date: DateTime.now().toString(),
      files: image.isNotEmpty ? [image.first] : [],
      timestamp: ServerValue.timestamp,
    );

    if (image.isNotEmpty) {
      ref
          .read(chatDetailsProvider.notifier)
          .sendChatMessage(data, widget.chatId);
    }
  }

  void _pickAudio(BuildContext context) async {
    final imageManager = ImageManager();
    var image = await imageManager.fetchFiles(
      fileType: FileType.audio,
      // allowedExtensions: ["mp4", 3gp]
    );

    final data = MessageModel(
      message:
          widget.messageCtrl.text.isNotEmpty ? widget.messageCtrl.text : null,
      type: 'audio',
      senderId: userDto?.id.toString(),
      isMe: true,
      isLocal: false,
      repliedMessage: ref.read(chatDetailsProvider.notifier).replyingMessage,
      date: DateTime.now().toString(),
      files: image.isNotEmpty ? [image.first] : [],
      timestamp: ServerValue.timestamp,
    );
    if (image.isNotEmpty) {
      ref
          .read(chatDetailsProvider.notifier)
          .sendChatMessage(data, widget.chatId);
    }


  }
}
