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

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.isMe,
    required this.message,
    this.onRightSwipe,
  });

  final bool isMe;
  final MessageModel? message;
  final VoidCallback? onRightSwipe;

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: () {
        logger.e(message?.message);
        if (onRightSwipe != null) {
          onRightSwipe!();
        }
      },
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(15.dg),
          margin: EdgeInsets.only(
              right: isMe ? 0 : 16.w,
              top: 10.h,
              bottom: 10.h,
              left: isMe ? 16.w : 0),
          decoration: BoxDecoration(
            color: isMe ? Pallets.primary : Pallets.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(16),
              bottomLeft: isMe ? Radius.circular(16) : Radius.circular(0),
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
              if (message?.repliedMessage != null)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
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
                        color: isMe ? Pallets.primaryLight : Pallets.primary,
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
              TextView(
                text: message?.message ?? '',
                fontSize: 14,
                color: isMe ? Pallets.white : Pallets.maybeBlack,
                fontWeight: FontWeight.w500,
              ),
              4.verticalSpace,
              TextView(
                text: TimeUtil.timeFormat(
                  message?.date ?? DateTime.now().toString(),
                ),
                fontSize: 12,
                color: isMe ? Pallets.white : Pallets.grey,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
