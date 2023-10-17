import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';
import 'package:triberly/app/chat/presentation/pages/chat_details/chat_details_controller.dart';
import 'package:triberly/app/chat/presentation/pages/chat_details/chat_details_page.dart';
import 'package:triberly/core/_core.dart';

class ChatBottomActionsBar extends StatefulWidget {
  const ChatBottomActionsBar({
    super.key,
    required this.messageCtrl,
    this.onSend,
    this.isRecording = false,
    this.audioCtrl,
    this.replyingMessage,
  });

  final TextEditingController messageCtrl;
  final MessageModel? replyingMessage;
  final VoidCallback? onSend;
  final bool isRecording;

  final RecorderController? audioCtrl;

  @override
  State<ChatBottomActionsBar> createState() => _ChatBottomActionsBarState();
}

class _ChatBottomActionsBarState extends State<ChatBottomActionsBar> {
  bool isAudio = true;

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
              if (ref.read(chatDetailsProvider.notifier).replyingMessage !=
                  null)
                Container(
                  color: Pallets.grey.withOpacity(0.1),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 3,
                            color: Pallets.black,
                          ),
                          16.horizontalSpace,
                          TextView(
                              text: ref
                                      .watch(chatDetailsProvider.notifier)
                                      .replyingMessage
                                      ?.message ??
                                  ''),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            ref
                                .watch(chatDetailsProvider.notifier)
                                .replyingMessage = null;
                          });
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Pallets.primary,
                        ),
                      )
                    ],
                  ),
                ),
              CustomDivider(),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {},
                    icon: Icon(
                      Icons.add,
                      // size: 24,
                      color: Pallets.grey,
                    ),
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
                        duration: Duration(milliseconds: 300),
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
}
