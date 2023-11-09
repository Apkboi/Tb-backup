import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';

import 'package:triberly/app/chat/presentation/widgets/wave_bubble.dart';

import '../../../../core/services/di/di.dart';
import '../../../../core/shared/text_view.dart';
import '../../../../core/utils/time_util.dart';
import '../../../auth/external/datasources/user_imp_dao.dart';
import '../pages/chat_details/chat_details_controller.dart';
import 'message_item.dart';

class BaseMessageWidget extends ConsumerStatefulWidget {
   BaseMessageWidget(this.index, {super.key, required this.singleItem});
   MessageModel singleItem;
   final int index;


  @override
  ConsumerState<BaseMessageWidget> createState() => _BaseMessageWidgetState();
}

class _BaseMessageWidgetState extends ConsumerState<BaseMessageWidget> {

  final userDto = sl<UserImpDao>().user;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {

        if (widget.singleItem.message == null && widget.singleItem.type == 'text') {
          return Center(
            child: TextView(
              text: TimeUtil.formatDate(
                widget.singleItem.date.toString(),
              ),
            ),
          );
        }

        // singleItem = normalList[index];
        if (widget.singleItem.type == 'audio') {
          return WaveBubble(
            // controller: playerController,
            index: widget.index,
            isSender: widget.singleItem.senderId == userDto?.id.toString(),
            audioUrl: widget.singleItem.message ?? '',
          );
        }
        // singleItem = normalList[index];

        return MessageItem(
          message: widget.singleItem,
          isMe: widget.singleItem.senderId == userDto?.id.toString(),
          onRightSwipe: () {
            // logger.e(singleItem.message);
            setState(() {
              ref.read(chatDetailsProvider.notifier).replyingMessage =
                  RepliedMessageModel(
                    senderName: 'mc_olumo',
                    isMe: true,
                    date: widget.singleItem.date,
                    message: widget.singleItem.message,
                    type: widget.singleItem.type,
                  );

              logger.e(ref
                  .read(chatDetailsProvider.notifier)
                  .replyingMessage
                  ?.message);
            });
          },
        );


      },
    );
  }
}
