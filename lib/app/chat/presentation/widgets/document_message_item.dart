import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';
import 'package:triberly/app/chat/presentation/pages/chat_details/chat_details_page.dart';
import 'package:triberly/app/chat/presentation/widgets/chat_bottom_action_bar.dart';
import 'package:triberly/app/chat/presentation/widgets/chat_detials_app_bar.dart';
import 'package:triberly/core/_core.dart';
import 'package:triberly/core/shared/video_widget.dart';

import '../controllers/send_message_controller.dart';
import 'message_retry_widget.dart';
final provider =
StateNotifierProvider<SendMessageController, SenMessageState>(
        (ref) => SendMessageController());
class DocumentMessageItem extends ConsumerWidget {
  DocumentMessageItem({
    super.key,
    required this.isMe,
    required this.message,
    this.onRightSwipe,
    required this.chatId,
  });

  final bool isMe;
  final MessageModel? message;
  final VoidCallback? onRightSwipe;
  final String chatId;
  bool eventHandled = false;



  final Debouncer debouncer = Debouncer(milliseconds: 1000);



  @override
  Widget build(BuildContext context, ref) {
    // logger.e(message?.message);
    debouncer.call(() {
      Future.delayed(Duration.zero, () {
        if (!eventHandled) {
          if (message!.isLocal && ref.read(provider) is SendMessageInitial) {
            ref.read(provider.notifier).sendChatMessage(message!, chatId);
          }

          eventHandled = true;
        }
      });
    });

    return SwipeTo(
      onRightSwipe: () {
        logger.e(message?.message);
        if (onRightSwipe != null) {
          onRightSwipe!();
        }
      },
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.dg),
              margin: EdgeInsets.only(
                  right: isMe ? 0 : 16.w,
                  top: 10.h,
                  bottom: 10.h,
                  left: isMe ? 16.w : 0),
              decoration: BoxDecoration(
                color: isMe ? Pallets.primary : Pallets.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(16),
                  bottomLeft: isMe
                      ? const Radius.circular(16)
                      : const Radius.circular(0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Pallets.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Checking for replied message
                  if (message?.repliedMessage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Pallets.white.withOpacity(.8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 40,
                            width: 3,
                            color:
                                isMe ? Pallets.primaryLight : Pallets.primary,
                          ),
                          16.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                text: message?.repliedMessage?.message ?? '',
                                color: Pallets.maybeBlack,
                              ),
                              5.verticalSpace,
                              TextView(
                                text: message?.repliedMessage?.senderName ?? '',
                                color: Pallets.maybeBlack,
                                fontSize: 12,
                              ),
                            ],
                          ),
                          32.horizontalSpace,
                        ],
                      ),
                    ),

                  _DocumentWidget(
                    message: message!,
                  ),

                  // Checking for Text Message
                  if (message?.message != null)
                    TextView(
                      text: message?.message ?? '',
                      fontSize: 14,
                      color: isMe ? Pallets.white : Pallets.maybeBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  4.verticalSpace,
                  TextView(
                    text: ref.watch(provider) is SendMessageLoading && message!.isLocal
                        ? "Sending.."
                        : TimeUtil.timeFormat(
                            message?.date ?? DateTime.now().toString(),
                          ),
                    fontSize: 12,
                    color: isMe ? Pallets.white : Pallets.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            ref.watch(provider) is SendMessageFailed && message!.isLocal
                ? MessageRetryWidget(onRetry: () {
                    ref
                        .read(provider.notifier)
                        .sendChatMessage(message!, chatId);
                  })
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class _DocumentWidget extends StatelessWidget {
  const _DocumentWidget({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    logger.i(message.type);
    if (message.type == "image") {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ImageWidget(
          imageUrl: message.files?.first ?? "",
          canPreview: true,
          imageType:
              message.isLocal ? ImageWidgetType.file : ImageWidgetType.network,
          height: 200,
          width: .8.sw,
        ),
      );
    }

    if (message.type == "video") {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: VideoWidget(
          videoPath: message.files?.first ?? "",
          videoType: VideoSourceType.network,
          height: 200,
          width: 0.8.sw,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
